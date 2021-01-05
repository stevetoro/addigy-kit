//
//  Policy.swift
//  
//
//  Created by Steve Toro on 1/5/21.
//

import Foundation

public struct Policy: Decodable {
    let parent: String?
    let policyID: String
    let orgID: String
    let name: String
    let icon: String
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case parent = "parent"
        case policyID = "policyId"
        case orgID = "orgid"
        case name = "name"
        case icon = "icon"
        case color = "color"
    }
}
