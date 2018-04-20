import UIKit
import ReadingListModel

class ReadingListController: UITableViewController
{
    @IBOutlet var dataSource: ReadingListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.load()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? "" {
        case "View Book":
            if
                let indexPath = tableView.indexPathForSelectedRow,
                let controller = segue.realDestination as? BookDetailController {
                controller.book = dataSource.book(at: indexPath)
            }
        case "Add Book":
            if let controller = segue.realDestination as? AddBookController {
                controller.completionHandler = { book in self.add(book: book) }
            }
        default: break
        }
    }
    
    func add(book: Book) {
        dataSource.insertBook(book: book, at: IndexPath(row: 0, section: 0))
        dataSource.save()
        tableView.reloadData()
    }
}

// MARK: - Unwind segues
extension ReadingListController
{
    @IBAction func doneEditing(segue: UIStoryboardSegue) {
        tableView.reloadData()
        dataSource.save()
    }
    
    @IBAction func doneAdding(segue: UIStoryboardSegue) { }
    @IBAction func cancelAdding(segue: UIStoryboardSegue) { }
}
