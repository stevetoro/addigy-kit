import XCTest

@testable import AddigyKit

final class AddigyKitTests: XCTestCase {
    
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

    static var allTests = [
        ("testInitializer", testInitializer)
    ]
}
