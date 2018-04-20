import UIKit

extension UIStoryboardSegue
{
    var realDestination: UIViewController? {
        guard let navController = destination as? UINavigationController else {
            return destination
        }
        return navController.topViewController
    }
}
