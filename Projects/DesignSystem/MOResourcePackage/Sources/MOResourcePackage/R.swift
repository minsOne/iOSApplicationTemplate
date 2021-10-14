import Foundation
import UIKit

public struct R {}

extension R {
    public struct Image {}
}

extension R {
    public struct Color {}
}

extension R {
    public struct Storyboard {
        let fileName: String
        let bundle: Bundle = .module
        init(name: String) {
            self.fileName = name
        }
    }
}
