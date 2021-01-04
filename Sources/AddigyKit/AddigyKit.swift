import Foundation
import Combine

@available(OSX 10.15, *)
public class Addigy {
    let clientID: String
    let clientSecret: String
    let realm: String
    let session: URLSession
    
    enum Errors: Error {
        case invalidClientKeys
    }
    
    init(clientID: String, clientSecret: String, realm: String = "prod", session: URLSession = .shared) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.realm = realm
        self.session = session
    }
    
    public func validate() -> AnyPublisher<String, Error> {
        struct ValidateResponse: Decodable {
            let OrgID: String
            
            enum CodingKeys: String, CodingKey {
                case OrgID = "orgid"
            }
        }
        
        var request = URLRequest(url: URL(string: "https://\(realm).addigy.com/api/validate")!)
        request.httpMethod = "POST"
        request.addValue(clientID, forHTTPHeaderField: "client-id")
        request.addValue(clientSecret, forHTTPHeaderField: "client-secret")
        
        return session.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if response.statusCode == 401 {
                    throw Addigy.Errors.invalidClientKeys
                }
                
                return element.data
            }
            .decode(type: ValidateResponse.self, decoder: JSONDecoder())
            .map(\.OrgID)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
