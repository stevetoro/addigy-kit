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
    
    public func validate() -> AnyPublisher<Token, Error> {
        return call(endpoint: "https://\(realm).addigy.com/api/validate", method: "POST")
    }
    
    public func getDevices() -> AnyPublisher<[Device], Error> {
        return call(endpoint: "https://\(realm).addigy.com/api/devices")
    }
    
    public func getOnlineDevices() -> AnyPublisher<[Device], Error> {
        return call(endpoint: "https://\(realm).addigy.com/api/devices/online")
    }
}

@available(OSX 10.15, *)
extension Addigy {
    private func call<Type: Decodable>(endpoint: String, method: String = "GET") -> AnyPublisher<Type, Error> {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = method
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
            .decode(type: Type.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
