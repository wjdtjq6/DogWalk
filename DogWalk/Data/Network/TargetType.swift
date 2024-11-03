//
//  TargetType.swift
//  DogWalk
//
//  Created by junehee on 11/2/24.
//

import Foundation

// HTTP 통신 메서드
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var query: [URLQueryItem]? { get }
    var body: Data? { get }
    // var boundary: String { get }   // multipart-form?
}

extension TargetType {
    func asURLRequest() throws -> URLRequest? {
        let base = try baseURL.asURL()
        
        var components = URLComponents(url: base.appending(path: path),
                                       resolvingAgainstBaseURL: false)
        components?.queryItems = query  // query 사용하는 경우
        
        guard let URL = components?.url else { throw URLError(.badURL) }
        var request = URLRequest(url: URL,
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: 30)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        request.httpBody = body
        return request
    }
}

/*
     func asURLRequest() throws -> URLRequest {
         let base = try base.asURL()

         var components = URLComponents(url: base.appendingPathComponent(path), resolvingAgainstBaseURL: false)
         
         /// query를 사용하는 경우
         components?.queryItems = query
         
         /// 예외처리
         guard let URL = components?.url else { throw URLError(.badURL) }
         
         var request = try URLRequest(url: URL, method: method)
         request.allHTTPHeaderFields = header
         request.httpBody = body
         return request
     }
 */

