//
//  WithDrawDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 회원탈퇴 응답 (Response)
struct WithDrawDTO: Decodable {
    let user_id: String
    let email: String
    let nick: String
}
