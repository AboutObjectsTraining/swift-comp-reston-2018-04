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
    var text: String? {
        didSet { sizeToFit() }
    }
    
    var highlighted: Bool = false {
        didSet {
            alpha  = highlighted ? 0.5 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
        configureGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayer() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
    }
    
    private func configureGestureRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(bounce(recognizer:)))
        tapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapRecognizer)
    }
}

// MARK: - Animation
extension CoolViewCell
{
    @IBAction func bounce(recognizer: UITapGestureRecognizer) {
        animateBounce(duration: 1, size: CGSize(width: 120, height: 240))
    }
    
    func animateBounce(duration: TimeInterval, size: CGSize) {
        
        UIView.animate(withDuration: duration,
                       animations: { [weak self] in self?.configureBounce(size: size) },
                       completion: { [weak self] _ in self?.animateFinalBounce(duration: duration, size: size) })
    }
    
    func animateFinalBounce(duration: TimeInterval, size: CGSize) {
        UIView.animate(withDuration: duration) { [weak self] in self?.transform = .identity }
    }
    
    func configureBounce(size: CGSize) {
        UIView.setAnimationRepeatCount(3.5)
        UIView.setAnimationRepeatAutoreverses(true)
        let translation = CGAffineTransform(translationX: size.width, y: size.height)
        transform = translation.rotated(by: .pi / 2)
    }
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
//        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let superview = superview else { return }
        let newLocation = touch.location(in: nil)
        let prevLocation = touch.previousLocation(in: nil)
        
        let deltaX = newLocation.x - prevLocation.x
        let deltaY = newLocation.y - prevLocation.y
        
        if superview.bounds.contains(frame.offsetBy(dx: deltaX, dy: 0)) {
            center.x += deltaX
        }
        
        if superview.bounds.contains(frame.offsetBy(dx: 0, dy: deltaY)) {
            center.y += deltaY
        }
//        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishTouch()
//        super.touchesEnded(touches, with: event)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishTouch()
//        super.touchesCancelled(touches, with: event)
    }
    
    func finishTouch() {
        highlighted = false
    }
}
