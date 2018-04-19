import UIKit

let coolCellNib = UINib(nibName: "CoolCell", bundle: nil)

class CoolView: UIView
{
    func addCell(text: String) {
        guard
            let obj = coolCellNib.instantiate(withOwner: nil, options: nil).first,
            let cell = obj as? CoolCell else { return }
        addSubview(cell)
        cell.text = text
    }
}
