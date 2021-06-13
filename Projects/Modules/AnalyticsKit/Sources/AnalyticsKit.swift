import Foundation
import ThirdPartyLibraryManager
import Firebase

public class Logger {}
public extension Logger {
    class Firebase {}
}

public extension Logger.Firebase {
    static func register(bundle: Bundle, plistName: String) {
        guard
            let filePath = bundle.path(forResource: plistName, ofType: "plist"),
            let fileopts = FirebaseOptions(contentsOfFile: filePath)
            else { return }
        
        FirebaseApp.configure(options: fileopts)
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-111",
            AnalyticsParameterItemName: "title",
            AnalyticsParameterContentType: "cont"
        ])
    }
}
