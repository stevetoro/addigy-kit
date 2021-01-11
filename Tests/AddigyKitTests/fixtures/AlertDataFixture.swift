//
//  AlertDataFixture.swift
//  
//
//  Created by Steve Toro on 1/6/21.
//

import Foundation

struct AlertDataFixture {
    static var getAlerts: Data {
        """
            [
                {
                    "_id": "test-alert-id",
                    "agentid": "test-agent-id",
                    "created_date": "test-date",
                    "orgid": "test-org-id",
                    "name": "test-alert-name-1",
                    "emails": [
                      "test@test.com"
                    ],
                    "fact_name": "test-fact-name-1",
                    "fact_identifier": "test-fact-identifier-1",
                    "category": "test-category-1",
                    "status": "test-status-1",
                    "level": "test-level-1",
                    "remenabled": true,
                    "value": "test-value",
                    "valuetype": "string"
                },
                {
                    "_id": "test-alert-id",
                    "agentid": "test-agent-id",
                    "created_date": "test-date",
                    "orgid": "test-org-id",
                    "name": "test-alert-name-2",
                    "emails": [
                      "test@test.com"
                    ],
                    "fact_name": "test-fact-name-2",
                    "fact_identifier": "test-fact-identifier-2",
                    "category": "test-category-2",
                    "status": "test-status-2",
                    "level": "test-level-2",
                    "remenabled": false,
                    "value": ["test-value-1", "test-value-2"],
                    "valuetype": "list"
                },
                {
                    "_id": "test-alert-id",
                    "agentid": "test-agent-id",
                    "created_date": "test-date",
                    "orgid": "test-org-id",
                    "name": "test-alert-name-3",
                    "emails": [
                      "test@test.com"
                    ],
                    "fact_name": "test-fact-name-3",
                    "fact_identifier": "test-fact-identifier-3",
                    "category": "test-category-3",
                    "status": "test-status-3",
                    "level": "test-level-3",
                    "remenabled": true,
                    "value": true,
                    "valuetype": "boolean"
                },
                {
                    "_id": "test-alert-id",
                    "agentid": "test-agent-id",
                    "created_date": "test-date",
                    "orgid": "test-org-id",
                    "name": "test-alert-name-4",
                    "emails": [
                      "test@test.com"
                    ],
                    "fact_name": "test-fact-name-4",
                    "fact_identifier": "test-fact-identifier-4",
                    "category": "test-category-4",
                    "status": "test-status-4",
                    "level": "test-level-4",
                    "remenabled": false,
                    "value": 200,
                    "valuetype": "number"
                },
                {
                    "_id": "test-alert-id",
                    "agentid": "test-agent-id",
                    "created_date": "test-date",
                    "orgid": "test-org-id",
                    "name": "test-alert-name-5",
                    "emails": [
                      "test@test.com"
                    ],
                    "fact_name": "test-fact-name-5",
                    "fact_identifier": "test-fact-identifier-5",
                    "category": "test-category-5",
                    "status": "test-status-5",
                    "level": "test-level-5",
                    "remenabled": true,
                    "value": "test-date-2",
                    "valuetype": "date"
                }
            ]
        """.data(using: .utf8)!
    }
}
