import UIKit

private let nib = UINib(nibName: "CoolViewCell", bundle: nil)

class CoolView: UIView
{
    func addCell(text: String) {
        // TODO: Load from a nib
        guard
            let obj = nib.instantiate(withOwner: nil, options: nil).first,
            let newCell = obj as? CoolViewCell else { return }
        newCell.text = text
        addSubview(newCell)
    }
}
