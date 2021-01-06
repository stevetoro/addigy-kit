import Foundation
import Combine

@available(OSX 10.15, iOS 13, tvOS 13.0, watchOS 6.0, *)
public class Addigy {
    let clientID: String
    let clientSecret: String
    let realm: String
    let session: URLSession
    let baseURL: String
    
    init(clientID: String, clientSecret: String, realm: String = "prod", session: URLSession = .shared) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.realm = realm
        self.session = session
        self.baseURL = "https://\(realm).addigy.com/api/"
    }
    
    public func validate() -> AnyPublisher<Token, Error> {
        return callAndDecode(endpoint: "validate", method: "POST")
    }
    
    public func getDevices() -> AnyPublisher<[Device], Error> {
        return callAndDecode(endpoint: "devices")
    }
    
    public func getOnlineDevices() -> AnyPublisher<[Device], Error> {
        return callAndDecode(endpoint: "devices/online")
    }
    
    public func getPolicies() -> AnyPublisher<[Policy], Error> {
        return callAndDecode(endpoint: "policies")
    }
    
    public func createPolicy(name: String, parent: String? = nil, icon: String? = nil, color: String? = nil) -> AnyPublisher<Policy, Error> {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let params = buildCreatePolicyParams(name: name, parent: parent, icon: icon, color: color)
        let body = params.queryParameters.data(using: .utf8, allowLossyConversion: true)

        return callAndDecode(endpoint: "policies", method: "POST", headers: headers, body: body)
    }
    
    public func getDevices(in policyID: String) -> AnyPublisher<[Device], Error> {
        return callAndDecode(endpoint: "policies/devices?policy_id=\(policyID)")
    }
    
    public func addDevice(withAgentID agentID: String, toPolicy policyID: String) -> AnyPublisher<String, Error> {
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let params = ["agent_id": agentID, "policy_id": policyID]
        let body = params.queryParameters.data(using: .utf8, allowLossyConversion: true)
        
        return call(endpoint: "policies/devices", method: "POST", headers: headers, body: body)
            .map { data in String(data: data, encoding: .utf8)! }
            .eraseToAnyPublisher()
    }
    
    public func getAlerts() -> AnyPublisher<[Alert], Error> {
        return callAndDecode(endpoint: "alerts")
    }
    
    public func getMaintenance() -> AnyPublisher<[Maintenance], Error> {
        return callAndDecode(endpoint: "maintenance")
    }
    
    private func buildCreatePolicyParams(name: String, parent: String? = nil, icon: String? = nil, color: String? = nil) -> [String:String] {
        var params = ["name": name]
        
        if let parent = parent {
            params["parent_id"] = parent
        }
        
        if let icon = icon {
            params["icon"] = icon
        }
        
        if let color = color {
            params["color"] = color
        }
        
        return params
    }
}

@available(OSX 10.15, iOS 13, tvOS 13.0, watchOS 6.0, *)
extension Addigy {
    enum Errors: Error {
        case unauthorized
    }
    
    private func call(endpoint: String, method: String = "GET", headers: [String:String] = [:], body: Data? = nil) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: URL(string: "\(baseURL)\(endpoint)")!)
        request.httpMethod = method
        request.addValue(clientID, forHTTPHeaderField: "client-id")
        request.addValue(clientSecret, forHTTPHeaderField: "client-secret")
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = body
        
        return session.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if response.statusCode == 401 {
                    throw Addigy.Errors.unauthorized
                }
                
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func callAndDecode<Type: Decodable>(endpoint: String, method: String = "GET", headers: [String:String] = [:], body: Data? = nil) -> AnyPublisher<Type, Error> {
        return call(endpoint: endpoint, method: method, headers: headers, body: body)
            .decode(type: Type.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
