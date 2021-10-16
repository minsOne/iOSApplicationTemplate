import Foundation
import TouchVisualizer

public struct DevTool {
    public static func startTouchVisualizer() {
        var conf = TouchVisualizer.Configuration()
        conf.color = .systemRed
        conf.defaultSize = .init(width: 30, height: 30)
        Visualizer.start(conf)
    }
}
