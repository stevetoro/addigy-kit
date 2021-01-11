//
//  Policy.swift
//  
//
//  Created by Steve Toro on 1/5/21.
//

import Foundation

public struct Policy: Decodable {
    public let parent: String?
    public let policyID: String
    public let orgID: String
    public let name: String
    public let icon: String
    public let color: String
    
    enum CodingKeys: String, CodingKey {
        case parent = "parent"
        case policyID = "policyId"
        case orgID = "orgid"
        case name = "name"
        case icon = "icon"
        case color = "color"
    }
}
