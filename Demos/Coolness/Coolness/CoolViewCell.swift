import UIKit

private let contentInsets = UIEdgeInsetsMake(7, 12, 8, 12)
private let textOrigin = CGPoint(x: contentInsets.left, y: contentInsets.top)
private let textAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: 18),
                                                            .foregroundColor: UIColor.white]

extension UIEdgeInsets
{
    var height: CGFloat { return contentInsets.top + contentInsets.bottom }
    var width: CGFloat { return contentInsets.left + contentInsets.right }
}


class CoolViewCell: UIView
{
    var text: String?
    
    var highlighted: Bool = false {
        didSet {
            alpha  = highlighted ? 0.5 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Animation
extension CoolViewCell
{
    
}

// MARK: - Custom drawing
extension CoolViewCell
{
    override func draw(_ rect: CGRect) {
        guard let text = text else { return }
        (text as NSString).draw(at: textOrigin, withAttributes: textAttributes)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let text = text else { return size }
        var newSize = (text as NSString).size(withAttributes: textAttributes)
        newSize.width += contentInsets.width
        newSize.height += contentInsets.height
        return newSize
    }
}

// MARK: - UIResponder methods
extension CoolViewCell
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        superview?.bringSubview(toFront: self)
        highlighted = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newLocation = touch.location(in: nil)
        let prevLocation = touch.previousLocation(in: nil)
        
        center.x += newLocation.x - prevLocation.x
        center.y += newLocation.y - prevLocation.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishTouch()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishTouch()
    }
    
    func finishTouch() {
        highlighted = false
    }
}
