import XCTest
import Combine

@testable import AddigyKit

final class AddigyKitTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    
    func testInitializer() {
        var client = Addigy(clientID: "test-client-id", clientSecret: "test-client-secret")
        XCTAssertEqual(client.clientID, "test-client-id")
        XCTAssertEqual(client.clientSecret, "test-client-secret")
        XCTAssertEqual(client.realm, "prod")
        XCTAssertEqual(client.session, .shared)
        
        let session = URLSession(configuration: .ephemeral)
        client = Addigy(clientID: "test-client-id", clientSecret: "test-client-secret", realm: "dev", session: session)
        XCTAssertEqual(client.realm, "dev")
        XCTAssertEqual(client.session, session)
    }
    
    func testValidate() {
        let url = URL(string: "https://prod.addigy.com/api/validate")
        let data = Data("{\"orgid\": \"test-org-id\"}".utf8)
        URLProtocolMock.testURLs = [url: data]

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "validate")
        client.validate()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { token in
                    XCTAssertEqual(token.orgID, "test-org-id")
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetDevices() {
        let url = URL(string: "https://prod.addigy.com/api/devices")
        let data = DeviceDataFixture.getDevices
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "getDevices")
        client.getDevices()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { devices in
                    XCTAssertEqual(devices.count, 2)
                    
                    var device = devices[0]
                    XCTAssertEqual(device.agentID, "test-agentid-1")
                    XCTAssertEqual(device.policyID, "test-policyid-1")
                    XCTAssertEqual(device.modelName, "test-device-model-name")
                    XCTAssertEqual(device.hardwareModel, "test-hardware-model")
                    XCTAssertEqual(device.osVersion, "test-os-version")
                    XCTAssertEqual(device.serial, "test-serial-number-1")
                    XCTAssertTrue(device.isOnline)
                    XCTAssertTrue(device.hasMDM)
                    XCTAssertFalse(device.isSupervised)
                    
                    device = devices[1]
                    XCTAssertEqual(device.agentID, "test-agentid-2")
                    XCTAssertEqual(device.policyID, "test-policyid-1")
                    XCTAssertEqual(device.modelName, "test-device-model-name")
                    XCTAssertEqual(device.hardwareModel, "test-hardware-model")
                    XCTAssertEqual(device.osVersion, "test-os-version")
                    XCTAssertEqual(device.serial, "test-serial-number-2")
                    XCTAssertFalse(device.isOnline)
                    XCTAssertFalse(device.hasMDM)
                    XCTAssertFalse(device.isSupervised)
                    
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetOnlineDevices() {
        let url = URL(string: "https://prod.addigy.com/api/devices/online")
        let data = DeviceDataFixture.getOnlineDevices
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "getOnlineDevices")
        client.getOnlineDevices()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { devices in
                    XCTAssertEqual(devices.count, 1)
                    
                    let device = devices[0]
                    XCTAssertEqual(device.agentID, "test-agentid-1")
                    XCTAssertEqual(device.policyID, "test-policyid-1")
                    XCTAssertEqual(device.modelName, "test-device-model-name")
                    XCTAssertEqual(device.hardwareModel, "test-hardware-model")
                    XCTAssertEqual(device.osVersion, "test-os-version")
                    XCTAssertEqual(device.serial, "test-serial-number-1")
                    XCTAssertTrue(device.isOnline)
                    XCTAssertTrue(device.hasMDM)
                    XCTAssertTrue(device.isSupervised)
                    
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetPolicies() {
        let url = URL(string: "https://prod.addigy.com/api/policies")
        let data = PolicyDataFixture.getPolicies
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "getPolicies")
        client.getPolicies()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { policies in
                    XCTAssertEqual(policies.count, 2)
                    
                    var policy = policies[0]
                    XCTAssertEqual(policy.policyID, "test-policy-id-1")
                    XCTAssertNil(policy.parent)
                    XCTAssertEqual(policy.orgID, "test-org-id")
                    XCTAssertEqual(policy.name, "test-name-1")
                    XCTAssertEqual(policy.icon, "test-icon")
                    XCTAssertEqual(policy.color, "test-color")
                    
                    policy = policies[1]
                    XCTAssertEqual(policy.policyID, "test-policy-id-2")
                    XCTAssertEqual(policy.parent, "test-policy-id-1")
                    XCTAssertEqual(policy.orgID, "test-org-id")
                    XCTAssertEqual(policy.name, "test-name-2")
                    XCTAssertEqual(policy.icon, "test-icon")
                    XCTAssertEqual(policy.color, "test-color")

                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testCreatePolicy() {
        let url = URL(string: "https://prod.addigy.com/api/policies")
        let data = PolicyDataFixture.createPolicy
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "createPolicy")
        client.createPolicy(name: "test-policy-name")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { policy in
                    XCTAssertEqual(policy.name, "test-policy-name")
                    XCTAssertEqual(policy.policyID, "test-policy-id")
                    XCTAssertEqual(policy.parent, "test-parent-id")
                    XCTAssertEqual(policy.orgID, "test-org-id")
                    XCTAssertEqual(policy.icon, "test-icon")
                    XCTAssertEqual(policy.color, "test-color")
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetDevicesInPolicy() {
        let testPolicyID = "test-policy-id"
        let url = URL(string: "https://prod.addigy.com/api/policies/devices?policy_id=\(testPolicyID)")
        let data = DeviceDataFixture.getDevicesInPolicy
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "getDevicesInPolicy")
        client.getDevices(in: testPolicyID)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { devices in
                    XCTAssertEqual(devices.count, 1)
                    
                    let device = devices[0]
                    XCTAssertEqual(device.agentID, "test-agent-id")
                    XCTAssertEqual(device.policyID, "test-policy-id")
                    XCTAssertEqual(device.serial, "test-serial-number")
                    XCTAssertEqual(device.modelName, "test-device-model-name")
                    XCTAssertEqual(device.hardwareModel, "test-hardware-model")
                    XCTAssertEqual(device.osVersion, "test-os-version")
                    XCTAssertFalse(device.isOnline)
                    XCTAssertTrue(device.hasMDM)
                    XCTAssertFalse(device.isSupervised)
                    
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testAddDeviceToPolicy() {
        let url = URL(string: "https://prod.addigy.com/api/policies/devices")
        let data = "".data(using: .utf8)!
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "addDeviceToPolicy")
        client.addDevice(withAgentID: "test-agent-id", toPolicy: "test-policy-id")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { value in
                    XCTAssertEqual(value, "")
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
    }
    
    func testGetAlerts() {
        let url = URL(string: "https://prod.addigy.com/api/alerts")
        let data = AlertDataFixture.getAlerts
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "testGetAlerts")
        client.getAlerts()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { alerts in
                    XCTAssertEqual(alerts.count, 5)
                    
                    var alert = alerts[0]
                    XCTAssertEqual(alert.id, "test-alert-id")
                    XCTAssertEqual(alert.agentId, "test-agent-id")
                    XCTAssertEqual(alert.createdDate, "test-date")
                    XCTAssertEqual(alert.orgId, "test-org-id")
                    XCTAssertEqual(alert.name, "test-alert-name-1")
                    XCTAssertEqual(alert.emails.count, 1)
                    XCTAssertEqual(alert.emails[0], "test@test.com")
                    XCTAssertEqual(alert.factName, "test-fact-name-1")
                    XCTAssertEqual(alert.factIdentifier, "test-fact-identifier-1")
                    XCTAssertEqual(alert.status, "test-status-1")
                    XCTAssertEqual(alert.level, "test-level-1")
                    XCTAssertTrue(alert.isRemediationEnabled)
                    XCTAssertEqual(alert.valueType, "string")
                    XCTAssertNoThrow(alert.value as! String)
                    XCTAssertEqual(alert.value as! String, "test-value")
                    
                    alert = alerts[1]
                    XCTAssertEqual(alert.id, "test-alert-id")
                    XCTAssertEqual(alert.agentId, "test-agent-id")
                    XCTAssertEqual(alert.createdDate, "test-date")
                    XCTAssertEqual(alert.orgId, "test-org-id")
                    XCTAssertEqual(alert.name, "test-alert-name-2")
                    XCTAssertEqual(alert.emails.count, 1)
                    XCTAssertEqual(alert.emails[0], "test@test.com")
                    XCTAssertEqual(alert.factName, "test-fact-name-2")
                    XCTAssertEqual(alert.factIdentifier, "test-fact-identifier-2")
                    XCTAssertEqual(alert.status, "test-status-2")
                    XCTAssertEqual(alert.level, "test-level-2")
                    XCTAssertFalse(alert.isRemediationEnabled)
                    XCTAssertEqual(alert.valueType, "list")
                    XCTAssertNoThrow(alert.value as! [String])
                    let list = alert.value as! [String]
                    XCTAssertEqual(list.count, 2)
                    XCTAssertEqual(list[0], "test-value-1")
                    XCTAssertEqual(list[1], "test-value-2")
                    
                    alert = alerts[2]
                    XCTAssertEqual(alert.id, "test-alert-id")
                    XCTAssertEqual(alert.agentId, "test-agent-id")
                    XCTAssertEqual(alert.createdDate, "test-date")
                    XCTAssertEqual(alert.orgId, "test-org-id")
                    XCTAssertEqual(alert.name, "test-alert-name-3")
                    XCTAssertEqual(alert.emails.count, 1)
                    XCTAssertEqual(alert.emails[0], "test@test.com")
                    XCTAssertEqual(alert.factName, "test-fact-name-3")
                    XCTAssertEqual(alert.factIdentifier, "test-fact-identifier-3")
                    XCTAssertEqual(alert.status, "test-status-3")
                    XCTAssertEqual(alert.level, "test-level-3")
                    XCTAssertTrue(alert.isRemediationEnabled)
                    XCTAssertEqual(alert.valueType, "boolean")
                    XCTAssertNoThrow(alert.value as! Bool)
                    XCTAssertTrue(alert.value as! Bool)
                    
                    alert = alerts[3]
                    XCTAssertEqual(alert.id, "test-alert-id")
                    XCTAssertEqual(alert.agentId, "test-agent-id")
                    XCTAssertEqual(alert.createdDate, "test-date")
                    XCTAssertEqual(alert.orgId, "test-org-id")
                    XCTAssertEqual(alert.name, "test-alert-name-4")
                    XCTAssertEqual(alert.emails.count, 1)
                    XCTAssertEqual(alert.emails[0], "test@test.com")
                    XCTAssertEqual(alert.factName, "test-fact-name-4")
                    XCTAssertEqual(alert.factIdentifier, "test-fact-identifier-4")
                    XCTAssertEqual(alert.status, "test-status-4")
                    XCTAssertEqual(alert.level, "test-level-4")
                    XCTAssertFalse(alert.isRemediationEnabled)
                    XCTAssertEqual(alert.valueType, "number")
                    XCTAssertNoThrow(alert.value as! Float)
                    XCTAssertEqual(alert.value as! Float, 200)
                    
                    alert = alerts[4]
                    XCTAssertEqual(alert.id, "test-alert-id")
                    XCTAssertEqual(alert.agentId, "test-agent-id")
                    XCTAssertEqual(alert.createdDate, "test-date")
                    XCTAssertEqual(alert.orgId, "test-org-id")
                    XCTAssertEqual(alert.name, "test-alert-name-5")
                    XCTAssertEqual(alert.emails.count, 1)
                    XCTAssertEqual(alert.emails[0], "test@test.com")
                    XCTAssertEqual(alert.factName, "test-fact-name-5")
                    XCTAssertEqual(alert.factIdentifier, "test-fact-identifier-5")
                    XCTAssertEqual(alert.status, "test-status-5")
                    XCTAssertEqual(alert.level, "test-level-5")
                    XCTAssertTrue(alert.isRemediationEnabled)
                    XCTAssertEqual(alert.valueType, "date")
                    XCTAssertNoThrow(alert.value as! String)
                    XCTAssertEqual(alert.value as! String, "test-date-2")
                    
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
    }
    
    func testGetMaintenance() {
        let url = URL(string: "https://prod.addigy.com/api/maintenance")
        let data = MaintenanceDataFixture.getMaintenance
        URLProtocolMock.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let client = Addigy(
            clientID: "test-client-id",
            clientSecret: "test-client-secret",
            session: session
        )
        
        let expectation = XCTestExpectation(description: "testGetMaintenance")
        client.getMaintenance()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { maintenance in
                    XCTAssertEqual(maintenance.count, 1)
                    
                    let maintenance = maintenance[0]
                    XCTAssertEqual(maintenance.actionType, "test-action-type")
                    XCTAssertEqual(maintenance.agentID, "test-agent-id")
                    XCTAssertEqual(maintenance.exitCode, 0)
                    XCTAssertEqual(maintenance.jobID, "test-job-id")
                    XCTAssertEqual(maintenance.jobTime, 60)
                    XCTAssertEqual(maintenance.maxTryCount, 1)
                    XCTAssertEqual(maintenance.name, "test-maintenance-name")
                    XCTAssertEqual(maintenance.orgID, "test-org-id")
                    XCTAssertEqual(maintenance.scheduledMaintenanceID, "test-scheduled-maintenance-id")
                    XCTAssertEqual(maintenance.scheduledMaintenanceTime, "17")
                    XCTAssertTrue(maintenance.shouldPromptUser)
                    XCTAssertEqual(maintenance.status, "test-status")
                    XCTAssertEqual(maintenance.tryCount, 0)
                    XCTAssertEqual(maintenance.type, "test-maintenance-type")

                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }

    static var allTests = [
        ("testInitializer", testInitializer),
        ("testValidate", testValidate),
        ("testGetDevices", testGetDevices),
        ("testGetOnlineDevices", testGetOnlineDevices),
        ("testGetPolicies", testGetPolicies),
        ("testCreatePolicy", testCreatePolicy),
        ("testGetDevicesInPolicy", testGetDevicesInPolicy),
        ("testAddDeviceToPolicy", testAddDeviceToPolicy),
        ("testGetAlerts", testGetAlerts),
        ("testGetMaintenance", testGetMaintenance),
    ]
}
