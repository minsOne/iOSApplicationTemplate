import Foundation
import UIKit
public struct R {
    static var bundle: Bundle { return .module }

    public struct Image {}
    public struct Color {}
}

func getImage(urlPath: String) -> UIImage? {
    guard
        let url = URL(string: urlPath),
        let data = try? Data(contentsOf: url),
        let image = UIImage(data: data)
    else { return nil }

    return image
}

func getImage1(urlPath: String) -> UIImage? {
    return URL(string: urlPath)
        .flatMap { try? Data(contentsOf: $0) }
        .map { UIImage(data: $0) }
    guard
        let url = URL(string: urlPath),
        let data = try? Data(contentsOf: url),
        let image = UIImage(data: data)
    else { return nil }
    
    return image
}
