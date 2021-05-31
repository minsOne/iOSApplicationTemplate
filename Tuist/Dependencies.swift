import ProjectDescription

let dependencies = Dependencies(
    carthage: .carthage(
        [
            .github(path: "FLEXTool/FLEX", requirement: .branch("master"))
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
