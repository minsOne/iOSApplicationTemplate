//
//  HomeAPI+BinGet.swift
//  NetworkAPIHome
//
//  Created by minsone on 2021/07/11.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import NetworkAPIKit

public extension HomeAPI {
    struct BinGet: APIRequestDefinition {
        public typealias BodyParameter = NetworkAPIKit.EmptyBodyParameter

        public let method: HTTPMethod = .get
        public let path: String = "latest/by-lat-lng"
        public var queryParameters: [String : String]? {
            ["lat": "12.9889055",
             "lng": "77.574044"]
        }
        
        public init() {}
    }
}

public extension HomeAPI.BinGet {
    struct Response: Decodable {
        public init(from decoder: Decoder) throws {}
    }
}

