import ProjectDescription

let dependencies = Dependencies(
    carthage: .init(
        [
            .github(path: "minsone-opensource-fork/FLEX",
                    requirement: .revision("2ad3092f4b9e31fc7294e45f3ee241324e17f0b3")),
            .github(path: "ReactiveX/RxSwift",
                    requirement: .branch("main")),
            .github(path: "Quick/Quick",
                    requirement: .branch("main")),
            .github(path: "Quick/Nimble",
                    requirement: .branch("main")),
            .github(path: "RxSwiftCommunity/RxNimble",
                    requirement: .branch("master")),
            .github(path: "uber/RIBs",
                    requirement: .branch("master")),
            .github(path: "ReactorKit/ReactorKit",
                    requirement: .branch("master")),
            .github(path: "ReactorKit/WeakMapTable",
                    requirement: .branch("master")),
            .github(path: "layoutBox/FlexLayout",
                    requirement: .branch("master")),
            .github(path: "layoutBox/PinLayout",
                    requirement: .branch("master")),
            .github(path: "SnapKit/SnapKit",
                    requirement: .branch("main")),
        ]
    ),
    swiftPackageManager: .init(
        [
//            .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master")),
//            .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
//            .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .branch("master")),
//            .package(url: "https://github.com/layoutBox/FlexLayout.git", .branch("master")),
//            .package(url: "https://github.com/ReactorKit/ReactorKit.git", .branch("master")),
//            .package(url: "https://github.com/uber/RIBs.git", .branch("master")),
//            .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
//            .local(path: .relativeToRoot("Projects/UserInterface/ResourcePackage")),
        ]
    ),
    platforms: [.iOS]
)
