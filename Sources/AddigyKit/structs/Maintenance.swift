//
//  Maintenance.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

public struct Maintenance: Decodable {
    let actionType: String
    let agentID: String
    let exitCode: Int
    let jobID: String
    let jobTime: Int
    let maxTryCount: Int
    let name: String
    let orgID: String
    let scheduledMaintenanceID: String
    let scheduledMaintenanceTime: String
    let shouldPromptUser: Bool
    let status: String
    let tryCount: Int
    let type: String

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
