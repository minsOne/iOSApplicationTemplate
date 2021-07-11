import UIKit
import RIBs
import NetworkAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        PrepareAppDelegateService().load()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
        
        #if DEBUG
        PrepareDevelopToolService().load()
        #endif
        
        #if DEBUG
        API.Common.BinGet().request(completion: {_ in })
        API.Home.BinGet().request(completion: {_ in })
        API.Login.BinGet().request(completion: {_ in })
        #endif
        
        return true
    }
}
