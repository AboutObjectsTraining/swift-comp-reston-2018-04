import UIKit

class ReadingListController: UITableViewController
{
    @IBAction func doneEditing(segue: UIStoryboardSegue) {
        print("In \(#function)")
    }
}

// MARK: - UITableViewDataSource methods
extension ReadingListController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Book Summary") else {
            fatalError("Make sure the reuse identifier is set in the storyboard or nib file")
        }
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}
