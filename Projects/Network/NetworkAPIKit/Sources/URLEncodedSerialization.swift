//
//  URLEncodedSerialization.swift
//  NetworkAPIKit
//
//  Created by minsone on 2021/07/27.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation

public final class URLEncodedSerialization {
    /// Returns urlencoded `String` from the dictionary.
    public static func string(from dictionary: [String: String]) -> String {
        let pairs = dictionary.map { key, value -> String in
            return value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                .flatMap { "\(key)=\($0)" } ?? ""
        }
        
        return pairs.joined(separator: "&")
    }
}
