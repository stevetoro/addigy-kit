//
//  Token.swift
//  
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

public struct Token: Decodable {
    public let orgId: String
    
    enum CodingKeys: String, CodingKey {
        case orgId = "orgid"
    }
    
    public init(orgID: String) {
        self.orgId = orgID
    }
}
