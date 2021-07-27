//
//  LoginAPI+BinGet.swift
//  NetworkAPILogin
//
//  Created by minsone on 2021/07/11.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import NetworkAPIKit

public extension LoginAPI {
    struct BinGet: APIRequestDefinition {
        public typealias BodyParameter = NetworkAPIKit.EmptyBodyParameter
        
        public let method: HTTPMethod = .get
        public let path: String = "anything/login/bin"
        public var queryParameters: [String : String]? {
            ["aa": "bb"]
        }
        public init() {}
    }
}

public extension LoginAPI.BinGet {
    struct Response: Codable {
        public init(from decoder: Decoder) throws {}
    }
}

