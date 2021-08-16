import UIKit
import RxPackage
import RIBs
import ThirdPartyLibraryManager
import ThirdPartyDynamicLibraryPluginManager
import NetworkAPIs

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
        API.Home.BinGet().request(completion: { result in print(result) })
//        API.Login.BinGet().request(completion: { result in print(result) })
        #endif
        
        return true
    }
}
