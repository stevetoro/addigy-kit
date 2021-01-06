//
//  URLProtocolMock.swift
//  
//
//  Created by Steve Toro on 1/4/21.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url] {
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/2.0", headerFields: ["data": data.base64EncodedString()])
                self.client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
            }
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
