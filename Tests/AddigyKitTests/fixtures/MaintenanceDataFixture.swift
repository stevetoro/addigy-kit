//
//  MaintenanceDataFixture.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

struct MaintenanceDataFixture {
    static var getMaintenance: Data {
        """
            [
                {
                    "_id": "test-maintenance-id",
                    "actiontype": "test-action-type",
                    "agentid": "test-agent-id",
                    "exitcode": 0,
                    "jobid": "test-job-id",
                    "jobtime": 60,
                    "maxtrycount": 1,
                    "maintenancename": "test-maintenance-name",
                    "orgid": "test-org-id",
                    "scheduled_maintenance_id": "test-scheduled-maintenance-id",
                    "scheduledtime": "17",
                    "promptuser": true,
                    "status": "test-status",
                    "trycount": 0,
                    "maintenancetype": "test-maintenance-type"
                }
            ]
        """.data(using: .utf8)!
    }
}
