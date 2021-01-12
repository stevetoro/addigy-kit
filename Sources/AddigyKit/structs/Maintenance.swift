//
//  Maintenance.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

public struct Maintenance: Decodable {
    public let actionType: String
    public let agentId: String
    public let exitCode: Int
    public let id: String
    public let jobId: String
    public let jobTime: Int
    public let maxTryCount: Int
    public let name: String
    public let orgId: String
    public let scheduledMaintenanceId: String
    public let scheduledMaintenanceTime: String
    public let shouldPromptUser: Bool
    public let status: String
    public let tryCount: Int
    public let type: String

    enum CodingKeys: String, CodingKey {
        case actionType = "actiontype"
        case agentId = "agentid"
        case exitCode = "exitcode"
        case id = "_id"
        case jobId = "jobid"
        case jobTime = "jobtime"
        case maxTryCount = "maxtrycount"
        case name = "maintenancename"
        case orgId = "orgid"
        case scheduledMaintenanceId = "scheduled_maintenance_id"
        case scheduledMaintenanceTime = "scheduledtime"
        case shouldPromptUser = "promptuser"
        case status = "status"
        case tryCount = "trycount"
        case type = "maintenancetype"
    }
    
    public init(actionType: String, agentId: String, exitCode: Int, id: String, jobId: String, jobTime: Int, maxTryCount: Int, name: String, orgId: String, scheduledMaintenanceId: String, scheduledMaintenanceTime: String, shouldPromptUser: Bool, status: String, tryCount: Int, type: String) {
        self.actionType = actionType
        self.agentId = agentId
        self.exitCode = exitCode
        self.id = id
        self.jobId = jobId
        self.jobTime = jobTime
        self.maxTryCount = maxTryCount
        self.name = name
        self.orgId = orgId
        self.scheduledMaintenanceId = scheduledMaintenanceId
        self.scheduledMaintenanceTime = scheduledMaintenanceTime
        self.shouldPromptUser = shouldPromptUser
        self.status = status
        self.tryCount = tryCount
        self.type = type
    }
}
