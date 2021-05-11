import UIKit

struct AAA: Codable {
    var person: String
    var name: String
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        let a = AAA(person: "ahn", name: "jungmin")
        let data = try? JSONEncoder().encode(a)
        let b = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
        
        return true
    }

}
