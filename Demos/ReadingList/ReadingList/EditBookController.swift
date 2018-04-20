import UIKit
import ReadingListModel

class EditBookController: UITableViewController
{
    var book: Book?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentBook()
        titleField.becomeFirstResponder()
    }
    
    func presentBook() {
        titleField.text = book?.title
        yearField.text = book?.year
        firstNameField.text = book?.author?.firstName
        lastNameField.text = book?.author?.lastName
    }
    
    func applyChanges() {
        book?.title = titleField.text
        book?.year = yearField.text
        book?.author?.firstName = firstNameField.text
        book?.author?.lastName = lastNameField.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Done" {
            applyChanges()
        }
    }
}

