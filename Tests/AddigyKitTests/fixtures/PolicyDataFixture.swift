//
//  PolicyDataFixture.swift
//  
//
//  Created by Steve Toro on 1/5/21.
//

import Foundation

struct PolicyDataFixture {
    static var getPolicies: Data {
        """
            [
                {
                    "color": "test-color",
                    "creation_time": 0,
                    "download_path": "test-download-path",
                    "icon": "test-icon",
                    "name": "test-name-1",
                    "orgid": "test-org-id",
                    "parent": null,
                    "policyId": "test-policy-id-1"
                },
                {
                    "color": "test-color",
                    "creation_time": 0,
                    "download_path": "test-download-path",
                    "icon": "test-icon",
                    "name": "test-name-2",
                    "orgid": "test-org-id",
                    "parent": "test-policy-id-1",
                    "policyId": "test-policy-id-2"
                }
            ]
        """.data(using: .utf8)!
    }
}
