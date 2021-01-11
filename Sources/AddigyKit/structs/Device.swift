//
//  Device.swift
//  
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

public struct Device: Decodable {
    public let agentID: String
    public let policyID: String
    public let modelName: String
    public let hardwareModel: String
    public let osVersion: String
    public let serial: String
    public let isOnline: Bool
    public let hasMDM: Bool
    public let isSupervised: Bool
    
    enum CodingKeys: String, CodingKey {
        case agentID = "agentid"
        case policyID = "policy_id"
        case modelName = "Device Model Name"
        case hardwareModel = "Hardware Model"
        case osVersion = "OS Version"
        case serial = "Serial Number"
        case isOnline = "Online"
        case hasMDM = "Has MDM"
        case isSupervised = "Is Supervised"
    }
}
