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
        URLProtocolStub.testURLs = [url: data]

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]

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
        URLProtocolStub.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
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
        URLProtocolStub.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
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
        URLProtocolStub.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
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
        URLProtocolStub.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
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
        URLProtocolStub.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
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
        URLProtocolStub.testURLs = [url: data]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
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

    static var allTests = [
        ("testInitializer", testInitializer),
        ("testValidate", testValidate),
        ("testGetDevices", testGetDevices),
        ("testGetOnlineDevices", testGetOnlineDevices),
        ("testGetPolicies", testGetPolicies),
        ("testCreatePolicy", testCreatePolicy),
        ("testGetDevicesInPolicy", testGetDevicesInPolicy),
        ("testAddDeviceToPolicy", testAddDeviceToPolicy)
    ]
}
