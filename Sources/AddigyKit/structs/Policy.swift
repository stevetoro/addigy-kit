//
//  Policy.swift
//  
//
//  Created by Steve Toro on 1/5/21.
//

import Foundation

public struct Policy: Decodable {
    public let color: String
    public let icon: String
    public let name: String
    public let orgID: String
    public let parent: String?
    public let policyID: String

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case icon = "icon"
        case name = "name"
        case orgID = "orgid"
        case parent = "parent"
        case policyID = "policyId"
    }
    
    public init(color: String, icon: String, name: String, orgID: String, parent: String? = nil, policyID: String) {
        self.color = color
        self.icon = icon
        self.name = name
        self.orgID = orgID
        self.parent = parent
        self.policyID = policyID
    }
}
