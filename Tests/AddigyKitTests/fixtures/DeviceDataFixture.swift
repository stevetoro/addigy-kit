//
//  DeviceDataFixture.swift
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

struct DeviceDataFixture {
    static var getDevices: Data {
        """
            [
                {
                    "agentid": "test-agentid-1",
                    "policy_id": "test-policyid-1",
                    "Device Model Name": "test-device-model-name",
                    "Hardware Model": "test-hardware-model",
                    "OS Version": "test-os-version",
                    "Serial Number": "test-serial-number-1",
                    "Online": true,
                    "Has MDM": true,
                    "Is Supervised": false
                },
                {
                    "agentid": "test-agentid-2",
                    "policy_id": "test-policyid-1",
                    "Device Model Name": "test-device-model-name",
                    "Hardware Model": "test-hardware-model",
                    "OS Version": "test-os-version",
                    "Serial Number": "test-serial-number-2",
                    "Online": false,
                    "Has MDM": false,
                    "Is Supervised": false
                }
            ]
        """.data(using: .utf8)!
    }
    
    static var getOnlineDevices: Data {
        """
            [
                {
                    "agentid": "test-agentid-1",
                    "policy_id": "test-policyid-1",
                    "Device Model Name": "test-device-model-name",
                    "Hardware Model": "test-hardware-model",
                    "OS Version": "test-os-version",
                    "Serial Number": "test-serial-number-1",
                    "Online": true,
                    "Has MDM": true,
                    "Is Supervised": true
                }
            ]
        """.data(using: .utf8)!
    }
    
    static var getDevicesInPolicy: Data {
        """
            [
                {
                    "agentid": "test-agent-id",
                    "policy_id": "test-policy-id",
                    "Device Model Name": "test-device-model-name",
                    "Hardware Model": "test-hardware-model",
                    "OS Version": "test-os-version",
                    "Serial Number": "test-serial-number",
                    "Online": false,
                    "Has MDM": true,
                    "Is Supervised": false
                }
            ]
        """.data(using: .utf8)!
    }
}
