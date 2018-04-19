import UIKit

class CoolViewController: UIViewController
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func addCoolView() {
        let newCell = CoolViewCell(frame: .zero)
        newCell.text = textField.text
        contentView.addSubview(newCell)
    }
}

// MARK: - UITextFieldDelegate methods
extension CoolViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - View loading
extension CoolViewController
{
    // TODO: Delete me (if we're not using loadView4)
    static let nib = UINib(nibName: "CoolView", bundle: nil)
    
    func loadView4() {
        CoolViewController.nib.instantiate(withOwner: self, options: nil)
    }
    
    func loadView3() {
        Bundle.main.loadNibNamed("CoolView", owner: self, options: nil)
    }
    
    func loadView2() {
        guard
            let topLevelObjs = Bundle.main.loadNibNamed("CoolView", owner: nil, options: nil),
            let myView = topLevelObjs.first as? UIView else { return }
        
        view = myView
    }
    

     func loadView1() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.brown
        
        let (accessoryRect, contentRect) = UIScreen.main.bounds.divided(atDistance: 90, from: .minYEdge)
        let accessoryView = UIView(frame: accessoryRect)
        let contentView = UIView(frame: contentRect)
        self.contentView = contentView
        
        view.addSubview(accessoryView)
        view.addSubview(contentView)
        
        // Controls
        
        textField = UITextField(frame: CGRect(x: 15, y: 35, width: 240, height: 30))
        accessoryView.addSubview(textField)
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter some text"
        
        let button = UIButton(type: .system)
        accessoryView.addSubview(button)
        button.setTitle("Add", for: .normal)
        button.sizeToFit()
        
        button.frame = button.frame.offsetBy(dx: 260, dy: 35)
        
        button.addTarget(self, action: #selector(addCoolView), for: .touchUpInside)
        
        // Cells
        
        let cell1 = CoolViewCell(frame: CGRect(x: 20, y: 60, width: 100, height: 35))
        let cell2 = CoolViewCell(frame: CGRect(x: 50, y: 110, width: 100, height: 35))
        
        contentView.addSubview(cell1)
        contentView.addSubview(cell2)
        
        cell1.text = "Hello World! ⛄️"
        cell2.text = "Beer is good. Mmmm. 🍺"
        
        cell1.sizeToFit()
        cell2.sizeToFit()
        
        cell1.backgroundColor = UIColor.purple
        cell2.backgroundColor = UIColor.orange
        accessoryView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.6)
    }
}
