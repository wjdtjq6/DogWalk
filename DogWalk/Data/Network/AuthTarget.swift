//
//  AuthTarget.swift
//  DogWalk
//
//  Created by junehee on 11/1/24.
//

import Foundation

enum AuthTarget {
    case refreshToken    // 토큰 갱신
}

extension AuthTarget: TargetType {
    var baseURL: String {
        return APIKey.baseURL
    }
    
    var path: String {
        return "/auth/refresh"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: [String : String] {
        return [
            BaseHeader.productId.rawValue: APIKey.appID,
            BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
            BaseHeader.refresh.rawValue: "" // UserDefaults에 저장된 리프레시 토큰
        ]
    }
    
    var query: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
    // var boundary: String {
    //     return nil
    // }
}
