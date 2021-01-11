//
//  Token.swift
//  
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

public struct Token: Decodable {
    public let orgID: String
    
    enum CodingKeys: String, CodingKey {
        case orgID = "orgid"
    }
    
    public init(orgID: String) {
        self.orgID = orgID
    }
}
