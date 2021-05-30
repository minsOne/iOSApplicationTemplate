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
    swiftPackageManager: nil, // work in progress, pass `nil`
    platforms: [.iOS]
)
