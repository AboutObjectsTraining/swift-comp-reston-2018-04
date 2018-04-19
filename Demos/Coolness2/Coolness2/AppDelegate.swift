import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.yellow
        window?.rootViewController = CoolViewController(nibName: "CoolView", bundle: nil)
        
        window?.makeKeyAndVisible()
    }
}

extension AppDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("In \(#function)")
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { }
}

