import ProjectDescription

let dependencies = Dependencies(
    carthage: .carthage(
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
        ],
        options: [
            .useXCFrameworks,
            .noUseBinaries
        ]
    ),
    swiftPackageManager: .swiftPackageManager(
        [
            .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master")),
            .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
            .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .branch("master")),
            .package(url: "https://github.com/layoutBox/FlexLayout.git", .branch("master")),
            .local(path: .relativeToRoot("Projects/Modules/ResourcePackage")),
        ]
    ),
    platforms: [.iOS]
)
