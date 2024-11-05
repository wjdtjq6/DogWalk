//
//  KaKaoAppleLoginDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 카카오 & 애플 로그인 응답 (Response)
struct KaKaoAppleLoginDTO: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let profile: String
    let accessToken: String
    let refreshToken: String
}
