import UIKit
import ReadingListModel

class AddBookController: UITableViewController
{
    var completionHandler: ((Book) -> Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var bookDictionary: [String: Any] {
        return [Book.Keys.title: titleField.text ?? "",
                Book.Keys.year: yearField.text ?? "",
                Book.Keys.author: [
                    Author.Keys.firstName: firstNameField.text ?? "",
                    Author.Keys.lastName: lastNameField.text ?? ""]]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Done" {
            completionHandler?(Book(dictionary: bookDictionary))
        }
    }
}
