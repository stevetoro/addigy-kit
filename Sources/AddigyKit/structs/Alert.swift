//
//  Alert.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

public struct Alert: Decodable {
    public let agentId: String
    public let category: String
    public let createdDate: String
    public let emails: [String]
    public let factIdentifier: String
    public let factName: String
    public let id: String
    public let isRemediationEnabled: Bool
    public let level: String
    public let name: String
    public let orgId: String
    public let status: String
    public let value: Any
    public let valueType: String
    
    enum CodingKeys: String, CodingKey {
        case agentId = "agentid"
        case category = "category"
        case createdDate = "created_date"
        case emails = "emails"
        case factIdentifier = "fact_identifier"
        case factName = "fact_name"
        case id = "_id"
        case isRemediationEnabled = "remenabled"
        case level = "level"
        case name = "name"
        case orgId = "orgid"
        case status = "status"
        case value = "value"
        case valueType = "valuetype"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        agentId = try container.decode(String.self, forKey: .agentId)
        category = try container.decode(String.self, forKey: .category)
        createdDate = try container.decode(String.self, forKey: .createdDate)
        emails = try container.decode([String].self, forKey: .emails)
        factIdentifier = try container.decode(String.self, forKey: .factIdentifier)
        factName = try container.decode(String.self, forKey: .factName)
        id = try container.decode(String.self, forKey: .id)
        isRemediationEnabled = try container.decode(Bool.self, forKey: .isRemediationEnabled)
        level = try container.decode(String.self, forKey: .level)
        name = try container.decode(String.self, forKey: .name)
        orgId = try container.decode(String.self, forKey: .orgId)
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
    
    public init(agentId: String, category: String, createdDate: String, emails: [String], factIdentifier: String, factName: String, id: String, isRemediationEnabled: Bool, level: String, name: String, orgId: String, status: String, value: Any, valueType: String) {
        self.agentId = agentId
        self.category = category
        self.createdDate = createdDate
        self.emails = emails
        self.factIdentifier = factIdentifier
        self.factName = factName
        self.id = id
        self.isRemediationEnabled = isRemediationEnabled
        self.level = level
        self.name = name
        self.orgId = orgId
        self.status = status
        self.value = value
        self.valueType = valueType
    }
}
