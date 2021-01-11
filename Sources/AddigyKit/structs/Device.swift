//
//  Device.swift
//  
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

public struct Device: Decodable {
    public let agentId: String
    public let hardwareModel: String
    public let hasMDM: Bool
    public let isOnline: Bool
    public let isSupervised: Bool
    public let modelName: String
    public let osVersion: String
    public let policyId: String
    public let serial: String

    enum CodingKeys: String, CodingKey {
        case agentId = "agentid"
        case hardwareModel = "Hardware Model"
        case hasMDM = "Has MDM"
        case isOnline = "Online"
        case isSupervised = "Is Supervised"
        case modelName = "Device Model Name"
        case osVersion = "OS Version"
        case policyId = "policy_id"
        case serial = "Serial Number"
    }
    
    internal init(agentId: String, hardwareModel: String, hasMDM: Bool, isOnline: Bool, isSupervised: Bool, modelName: String, osVersion: String, policyId: String, serial: String) {
        self.agentId = agentId
        self.hardwareModel = hardwareModel
        self.hasMDM = hasMDM
        self.isOnline = isOnline
        self.isSupervised = isSupervised
        self.modelName = modelName
        self.osVersion = osVersion
        self.policyId = policyId
        self.serial = serial
    }
}
