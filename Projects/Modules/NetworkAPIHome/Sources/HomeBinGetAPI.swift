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
        public let method: HTTPMethod = .get
        
        public let path: String = "anything/home/bin"
        
        public var parameter: Parameter = Parameter()
        public init() {}
    }
}

public extension HomeAPI.BinGet {
    struct Parameter: Codable {
        public var aa: String = "bb"
    }
    
    struct Response: Codable {
        public init(from decoder: Decoder) throws {}
    }
}

