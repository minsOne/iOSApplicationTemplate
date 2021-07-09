//
//  File.swift
//  
//
//  Created by minsone on 2021/07/09.
//

import Foundation
import UIKit

public struct RImage {
    public let image: UIImage
    
    public init(_ name: String) {
        if let image = UIImage(named: name, in: .module, compatibleWith: nil) {
            self.image = image
        } else {
            assert(false, "해당 이미지가 없습니다.")
            self.image = UIImage()
        }
    }
}
