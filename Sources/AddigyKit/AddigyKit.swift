import Foundation

public class Addigy {
    let clientID: String
    let clientSecret: String
    let realm: String
    let session: URLSession
    
    init(clientID: String, clientSecret: String, realm: String = "prod", session: URLSession = .shared) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.realm = realm
        self.session = session
    }
}
