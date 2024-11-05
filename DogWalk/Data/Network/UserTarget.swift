//
//  UserTarget.swift
//  DogWalk
//
//  Created by junehee on 11/2/24.
//

import Foundation

enum UserTarget {
    case kakaoLogin(body: KaKaoLoginBody)       // 카카오 로그인
    case appleLogin(body: AppleLoginBody)       // 애플 로그인
    case myProfile                              // 내 프로필 조회
    case userProfile(userId: String)            // 다른 유저 프로필 조회
    case withdraw                               // 회원탈퇴
}

extension UserTarget: TargetType {
    var baseURL: String {
        return APIKey.baseURL
    }
    
    var path: String {
        switch self {
        case .kakaoLogin: 
            return "/users/login/kakao"
        case .appleLogin:
            return "/users/login/apple"
        case .myProfile:
            return "/users/me/profile"
        case .userProfile(let userId):
            return "/users/\(userId)/profile"
        case .withdraw:
            return "/users/withdraw"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .kakaoLogin, .appleLogin: 
            return .post
        case .myProfile, .userProfile, .withdraw:
            return .get
        }
    }
    
    var header: [String : String] {
        switch self {
        /// productId, application/json
        case .kakaoLogin, .appleLogin:
            return [
                BaseHeader.productId.rawValue: APIKey.appID,
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
            ]
        /// productId, application/json, AccessToken, SesacKey
        case .myProfile, .userProfile, .withdraw:
            return [
                BaseHeader.productId.rawValue: APIKey.appID,
                BaseHeader.contentType.rawValue: BaseHeader.json.rawValue,
                BaseHeader.authorization.rawValue: "", // UserDefaults에 저장된 액세스 토큰
                BaseHeader.sesacKey.rawValue: APIKey.key
            ]
        }
    }
    
    var query: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .kakaoLogin(let body):
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("Body to JSON Encode Error", error)
                return nil
            }
        case .appleLogin(let body):
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("Body to JSON Encode Error", error)
                return nil
            }
        default:
            return nil
        }
    }
    
    // var boundary: String {
    //     return nil
    // }
}
