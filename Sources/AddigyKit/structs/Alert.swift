//
//  Alert.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

public struct Alert: Decodable {
    public let agentID: String
    public let category: String
    public let emails: [String]
    public let factIdentifier: String
    public let factName: String
    public let isRemediationEnabled: Bool
    public let level: String
    public let name: String
    public let orgID: String
    public let status: String
    public let value: Any
    public let valueType: String
    
    enum CodingKeys: String, CodingKey {
        case agentID = "agentid"
        case category = "category"
        case emails = "emails"
        case factIdentifier = "fact_identifier"
        case factName = "fact_name"
        case isRemediationEnabled = "remenabled"
        case level = "level"
        case name = "name"
        case orgID = "orgid"
        case status = "status"
        case value = "value"
        case valueType = "valuetype"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        agentID = try container.decode(String.self, forKey: .agentID)
        category = try container.decode(String.self, forKey: .category)
        emails = try container.decode([String].self, forKey: .emails)
        factIdentifier = try container.decode(String.self, forKey: .factIdentifier)
        factName = try container.decode(String.self, forKey: .factName)
        isRemediationEnabled = try container.decode(Bool.self, forKey: .isRemediationEnabled)
        level = try container.decode(String.self, forKey: .level)
        name = try container.decode(String.self, forKey: .name)
        orgID = try container.decode(String.self, forKey: .orgID)
        status = try container.decode(String.self, forKey: .status)
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
    
    public init(agentID: String, category: String, emails: [String], factIdentifier: String, factName: String, isRemediationEnabled: Bool, level: String, name: String, orgID: String, status: String, value: Any, valueType: String) {
        self.agentID = agentID
        self.category = category
        self.emails = emails
        self.factIdentifier = factIdentifier
        self.factName = factName
        self.isRemediationEnabled = isRemediationEnabled
        self.level = level
        self.name = name
        self.orgID = orgID
        self.status = status
        self.value = value
        self.valueType = valueType
    }
}
