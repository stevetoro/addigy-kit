//
//  Alert.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

public struct Alert: Decodable {
    public let agentID: String
    public let orgID: String
    public let name: String
    public let emails: [String]
    public let factName: String
    public let factIdentifier: String
    public let category: String
    public let status: String
    public let level: String
    public let isRemediationEnabled: Bool
    public let value: Any
    public let valueType: String
    
    enum CodingKeys: String, CodingKey {
        case agentID = "agentid"
        case orgID = "orgid"
        case name = "name"
        case emails = "emails"
        case factName = "fact_name"
        case factIdentifier = "fact_identifier"
        case category = "category"
        case status = "status"
        case level = "level"
        case isRemediationEnabled = "remenabled"
        case value = "value"
        case valueType = "valuetype"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        agentID = try container.decode(String.self, forKey: .agentID)
        orgID = try container.decode(String.self, forKey: .orgID)
        name = try container.decode(String.self, forKey: .name)
        emails = try container.decode([String].self, forKey: .emails)
        factName = try container.decode(String.self, forKey: .factName)
        factIdentifier = try container.decode(String.self, forKey: .factIdentifier)
        category = try container.decode(String.self, forKey: .category)
        status = try container.decode(String.self, forKey: .status)
        level = try container.decode(String.self, forKey: .level)
        isRemediationEnabled = try container.decode(Bool.self, forKey: .isRemediationEnabled)
        valueType = try container.decode(String.self, forKey: .valueType)
        
        switch valueType {
        case "string":
            value = try container.decode(String.self, forKey: .value)
        case "list":
            value = try container.decode([String].self, forKey: .value)
        case "boolean":
            value = try container.decode(Bool.self, forKey: .value)
        case "number":
            value = try container.decode(Float.self, forKey: .value)
        case "date":
            value = try container.decode(String.self, forKey: .value)
        default:
            value = ""
        }

        return
    }
}
