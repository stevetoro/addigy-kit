//
//  Maintenance.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

public struct Maintenance: Decodable {
    public let actionType: String
    public let agentID: String
    public let exitCode: Int
    public let jobID: String
    public let jobTime: Int
    public let maxTryCount: Int
    public let name: String
    public let orgID: String
    public let scheduledMaintenanceID: String
    public let scheduledMaintenanceTime: String
    public let shouldPromptUser: Bool
    public let status: String
    public let tryCount: Int
    public let type: String

    enum CodingKeys: String, CodingKey {
        case actionType = "actiontype"
        case agentID = "agentid"
        case exitCode = "exitcode"
        case jobID = "jobid"
        case jobTime = "jobtime"
        case maxTryCount = "maxtrycount"
        case name = "maintenancename"
        case orgID = "orgid"
        case scheduledMaintenanceID = "scheduled_maintenance_id"
        case scheduledMaintenanceTime = "scheduledtime"
        case shouldPromptUser = "promptuser"
        case status = "status"
        case tryCount = "trycount"
        case type = "maintenancetype"
    }
}
