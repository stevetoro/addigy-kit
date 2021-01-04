//
//  Device.swift
//  
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

public struct Device: Codable {
    let agentID: String
    let policyID: String
    let modelName: String
    let hardwareModel: String
    let osVersion: String
    let serial: String
    let isOnline: Bool
    let hasMDM: Bool
    let isSupervised: Bool
    
    enum CodingKeys: String, CodingKey {
        case agentID = "agentid"
        case policyID = "policy_id"
        case modelName = "Device Model Name"
        case hardwareModel = "Hardware Model"
        case osVersion = "OS Version"
        case serial = "Serial Number"
        case isOnline = "online"
        case hasMDM = "Has MDM"
        case isSupervised = "Is Supervised"
    }
}
