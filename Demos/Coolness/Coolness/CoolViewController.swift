import UIKit

class CoolViewController: UIViewController
{
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.brown
        
        let cell1 = CoolViewCell(frame: CGRect(x: 20, y: 60, width: 100, height: 35))
        let cell2 = CoolViewCell(frame: CGRect(x: 50, y: 110, width: 100, height: 35))
        
        view.addSubview(cell1)
        view.addSubview(cell2)
        
        cell1.text = "Hello World! ⛄️"
        cell2.text = "Beer is good. Mmmm. 🍺"
        
        cell1.sizeToFit()
        cell2.sizeToFit()
        
        cell1.backgroundColor = UIColor.purple
        cell2.backgroundColor = UIColor.orange
    }
}

extension AppDelegate
{
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newLocation = touch.location(in: nil)
        let prevLocation = touch.previousLocation(in: nil)
        
        touch.view?.center.x += newLocation.x - prevLocation.x
        touch.view?.center.y += newLocation.y - prevLocation.y
    }
}
