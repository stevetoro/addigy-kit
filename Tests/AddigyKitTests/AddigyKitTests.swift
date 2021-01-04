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
                receiveValue: { value in
                    XCTAssertEqual(value, "test-org-id")
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }

    static var allTests = [
        ("testInitializer", testInitializer),
        ("testValidate", testValidate)
    ]
}
