import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.yellow
        window?.rootViewController = CoolViewController()
        
        window?.makeKeyAndVisible()
    }
}

 
