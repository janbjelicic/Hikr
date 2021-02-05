//
//  NetworkRequest.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation

public enum HTTPVerb: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

public enum RequestType {
    case data
    case download
    case upload
}

public enum ResponseType {
    case json
    case file
}

public protocol NetworkRequestProtocol {
    
    var path: String { get }
    var method: HTTPVerb { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var requestType: RequestType { get }
    var responseType: ResponseType { get }
 
}

extension NetworkRequestProtocol {
    
    public func urlRequest(with environment: APIEnvironmentProtocol) -> URLRequest? {
        // Create the base URL.
        guard let url = url(with: environment.baseURL) else {
            return nil
        }
        // Create a request with that URL.
        var request = URLRequest(url: url)

        // Append all related properties.
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonBody

        return request
    }

    /// Creates a URL with the given base URL.
    /// - Parameter baseURL: The base URL string.
    /// - Returns: An optional `URL`.
    private func url(with baseURL: String) -> URL? {
        // Create a URLComponents instance to compose the url.
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        // Add the request path to the existing base URL path
        urlComponents.path = urlComponents.path + path
        // Add query items to the request URL
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    /// Returns the URLRequest `URLQueryItem`
    private var queryItems: [URLQueryItem]? {
        // Chek if it is a GET method.
        guard method == .get, let parameters = parameters else {
            return nil
        }
        // Convert parameters to query items.
        return parameters.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }

    /// Returns the URLRequest body `Data`
    private var jsonBody: Data? {
        // The body data should be used for POST, PUT and PATCH only
        guard [.post, .put, .patch].contains(method), let parameters = parameters else {
            return nil
        }
        // Convert parameters to JSON data
        var jsonBody: Data?
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: parameters,
                                                  options: .prettyPrinted)
        } catch {
            print(error)
        }
        return jsonBody
    }
    
}
