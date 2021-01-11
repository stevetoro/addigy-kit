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
    public let orgId: String
    public let parent: String?
    public let policyId: String

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case icon = "icon"
        case name = "name"
        case orgId = "orgid"
        case parent = "parent"
        case policyId = "policyId"
    }
    
    public init(color: String, icon: String, name: String, orgId: String, parent: String? = nil, policyId: String) {
        self.color = color
        self.icon = icon
        self.name = name
        self.orgId = orgId
        self.parent = parent
        self.policyId = policyId
    }
}
