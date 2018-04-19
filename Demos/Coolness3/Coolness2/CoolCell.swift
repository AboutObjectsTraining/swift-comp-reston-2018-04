import UIKit

private let textInset = CGPoint(x: 12, y: 6)
private let textAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
                              NSAttributedStringKey.foregroundColor: UIColor.white]

@IBDesignable
class CoolCell: UIView
{
    @IBInspectable var text: String? {
        didSet { sizeToFit() }
    }
    
    @IBInspectable var repetitions: Float = 3.5
    
    var highlighted: Bool = false {
        willSet { alpha = newValue ? 0.5 : 1.0 }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
        configureGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayer()
        configureGestureRecognizers()
    }
}

let topCornerMask: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

// MARK: - Computed layer properties
extension UIView
{
    @IBInspectable var topRadiusOnly: Bool {
        get { return layer.maskedCorners == topCornerMask }
        set { layer.maskedCorners = topCornerMask }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            guard let color = layer.borderColor else { return UIColor.white }
            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue.cgColor }
    }
}

// MARK: - Configuration
extension CoolCell
{
    private func configureLayer() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    private func configureGestureRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(bounce))
        tapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapRecognizer)
    }
    
    override func prepareForInterfaceBuilder() {
        layer.masksToBounds = true
        sizeToFit()
    }
}


// MARK: - Animation
extension CoolCell
{
    @IBAction func bounce() {
        animateBounce(duration: 1, size: CGSize(width: 120, height: 240))
    }
    
    func configureBounce(duration: TimeInterval, size: CGSize) {
        UIView.setAnimationRepeatCount(repetitions)
        UIView.setAnimationRepeatAutoreverses(true)
        let translation = CGAffineTransform(translationX: size.width, y: size.height)
        transform = translation.rotated(by: CGFloat(.pi / 2.0))
    }
    
    func configureFinalBounce(duration: TimeInterval, size: CGSize) {
        print("In \(#function), \(#file):line \(#line)")
        UIView.animate(withDuration: duration) {
            [weak self] in self?.transform = CGAffineTransform.identity
        }
    }
    
    func animateBounce(duration: TimeInterval, size: CGSize) {
        UIView.animate(withDuration: duration,
                       animations: { [weak self]   in self?.configureBounce(duration: duration, size: size) },
                       completion: { [weak self] _ in self?.configureFinalBounce(duration: duration, size: size) })
    }
}

// MARK: - View Drawing
extension CoolCell
{
    override func draw(_ rect: CGRect) {
        guard let text = text else { return }
        (text as NSString).draw(at: textInset, withAttributes: textAttributes)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let text = text else { return size }
        var newSize = (text as NSString).size(withAttributes: textAttributes)
        newSize.width += 2 * textInset.x
        newSize.height += 2 * textInset.y
        return newSize
    }
}

extension UITouch
{
    var distanceMoved: CGSize {
        let currLocation = location(in: nil)
        let prevLocation = previousLocation(in: nil)
        return CGSize(width: currLocation.x - prevLocation.x, height: currLocation.y - prevLocation.y)
    }
}

extension CGRect
{
    func offsetBy(touch: UITouch) -> CGRect {
        let distanceMoved = touch.distanceMoved
        return offsetBy(dx: distanceMoved.width, dy: distanceMoved.height)
    }
}

// MARK: - Responder Methods
extension CoolCell
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = true
        guard let touch = touches.first, let view = touch.view else { return }
        view.superview?.bringSubview(toFront: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let superview = superview else { return }
//        let currLocation = touch.location(in: nil)
//        let prevLocation = touch.previousLocation(in: nil)
//        let deltaX = currLocation.x - prevLocation.x
//        let deltaY = currLocation.y - prevLocation.y
        
        let deltaX = touch.distanceMoved.width
        let deltaY = touch.distanceMoved.height
        if superview.bounds.contains(frame.offsetBy(dx: deltaX, dy: 0)) {
            center.x += deltaX
        }
        
        if superview.bounds.contains(frame.offsetBy(dx: 0, dy: deltaY)) {
            center.y += deltaY
        }
        
        //        let currLocation = touch.location(in: nil)
        //        let prevLocation = touch.previousLocation(in: nil)
        //        center.x += currLocation.x - prevLocation.x
        //        center.y += currLocation.y - prevLocation.y
    }
    
    func finish(touch: UITouch?) {
        highlighted = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        finish(touch: touches.first)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        finish(touch: touches.first)
    }
}

