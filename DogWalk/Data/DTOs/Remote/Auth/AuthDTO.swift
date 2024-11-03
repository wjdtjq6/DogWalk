//
//  AuthDTO.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import Foundation

// 토큰 갱신 응답 데이터 (Response)
struct AuthDTO {
    let accessToken: String
    let refreshToken: String
}
