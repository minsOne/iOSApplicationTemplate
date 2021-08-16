import UIKit
import Foundation
@testable import ResourcePackage

func storyboardResourcePath(_ storyboard: R.Storyboard) -> String? {
    storyboard.bundle.path(forResource: storyboard.fileName, ofType: "storyboardc")
}
