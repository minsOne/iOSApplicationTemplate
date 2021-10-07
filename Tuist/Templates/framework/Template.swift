import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let exampleContents = """
        import Foundation

        struct \(nameAttribute) { }
    """

let testContents = """
        import Foundation
        import XCTest

        final class \(nameAttribute)Tests: XCTestCase {

            override func setUp() {
                super.setUp()
            }

            override func tearDown() {
                super.tearDown()
            }

            func test_example() {
                // Add your test here
            }

        }
    """

let appDelegateContents = """
        import Foundation
        import UIKit

        @UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {
            var window: UIWindow?

            internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                let vc = UIViewController()
                vc.title = \(nameAttribute)

                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = UINavigationController(root: vc)
                self.window?.makeKeyAndVisible()
                return true
            }
        }
    """

let xcassetsContents = """
        {
          "info" : {
            "version" : 1,
            "author" : "xcode"
          }
        }
    """

let xcassetsAppIconContents = """
        {
          "images" : [
            {
              "idiom" : "iphone",
              "scale" : "2x",
              "size" : "20x20"
            },
            {
              "idiom" : "iphone",
              "scale" : "3x",
              "size" : "20x20"
            },
            {
              "idiom" : "iphone",
              "scale" : "2x",
              "size" : "29x29"
            },
            {
              "idiom" : "iphone",
              "scale" : "3x",
              "size" : "29x29"
            },
            {
              "idiom" : "iphone",
              "scale" : "2x",
              "size" : "40x40"
            },
            {
              "idiom" : "iphone",
              "scale" : "3x",
              "size" : "40x40"
            },
            {
              "idiom" : "iphone",
              "scale" : "2x",
              "size" : "60x60"
            },
            {
              "idiom" : "iphone",
              "scale" : "3x",
              "size" : "60x60"
            },
            {
              "idiom" : "ipad",
              "scale" : "1x",
              "size" : "20x20"
            },
            {
              "idiom" : "ipad",
              "scale" : "2x",
              "size" : "20x20"
            },
            {
              "idiom" : "ipad",
              "scale" : "1x",
              "size" : "29x29"
            },
            {
              "idiom" : "ipad",
              "scale" : "2x",
              "size" : "29x29"
            },
            {
              "idiom" : "ipad",
              "scale" : "1x",
              "size" : "40x40"
            },
            {
              "idiom" : "ipad",
              "scale" : "2x",
              "size" : "40x40"
            },
            {
              "idiom" : "ipad",
              "scale" : "1x",
              "size" : "76x76"
            },
            {
              "idiom" : "ipad",
              "scale" : "2x",
              "size" : "76x76"
            },
            {
              "idiom" : "ipad",
              "scale" : "2x",
              "size" : "83.5x83.5"
            },
            {
              "idiom" : "ios-marketing",
              "scale" : "1x",
              "size" : "1024x1024"
            }
          ],
          "info" : {
            "author" : "xcode",
            "version" : 1
          }
        }
    """

let testingContents = """
        public struct \(nameAttribute)TestingData {

        }
    """

let template = Template(
    description: "Framework template",
    attributes: [nameAttribute, .optional("platform", default: "iOS")],
    files: [
        .string(path: "\(nameAttribute)/Example/Sources/AppDelegate.swift", contents: appDelegateContents),
        .string(
            path: "\(nameAttribute)/Example/Resources/Assets.xcassets/contents.json",
            contents: xcassetsContents
        ),
        .string(
            path: "\(nameAttribute)/Example/Resources/Assets.xcassets/AppIcon.appiconset/contents.json",
            contents: xcassetsAppIconContents
        ),
        .string(path: "\(nameAttribute)/Sources/\(nameAttribute).swift", contents: exampleContents),
        .string(path: "\(nameAttribute)/Resources/dummy.txt", contents: "_"),
        .string(path: "\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", contents: testContents),
        .string(path: "\(nameAttribute)/Testing/Sources/\(nameAttribute).swift", contents: testingContents),
        .string(path: "\(nameAttribute)/Testing/Resources/dummy.txt", contents: "_"),
        .file(path: "\(nameAttribute)/Project.swift", templatePath: "project.stencil"),
    ]
)
