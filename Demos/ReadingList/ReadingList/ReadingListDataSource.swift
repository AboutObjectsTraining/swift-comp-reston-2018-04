import UIKit
import ReadingListModel

class ReadingListDataSource: NSObject
{
    // TODO: Add outlet for tableView
    lazy var store = ReadingListStore("BooksAndAuthors")
    var readingList: ReadingList?
    
    func load() {
        readingList = store.fetchedReadingList
    }
    
    func book(at indexPath: IndexPath) -> Book? {
        return readingList?.books[indexPath.row]
    }
    
    func insertBook(book: Book, at indexPath: IndexPath) {
        readingList?.books[indexPath.row] = book
    }
    
    func save() {
        guard let readingList = readingList else { return }
        store.save(readingList: readingList)
    }
}

extension ReadingListDataSource: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingList?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Book Summary"),
            let book = readingList?.books[indexPath.row] else {
            fatalError("Make sure the reuse identifier is set in the storyboard or nib file")
        }
        
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = "\(book.year ?? "N/A")  \(book.author?.fullName ?? "Unknown")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let book = readingList?.books[sourceIndexPath.row] else { return }
        readingList?.books.insert(book, at: destinationIndexPath.row)
        save()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        readingList?.books.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        save()
    }
}
