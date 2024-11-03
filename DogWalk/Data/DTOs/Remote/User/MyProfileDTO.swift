//
//  MyProfileDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 내 프로필 조회 응답 (Response)
struct MyProfileDTO: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let profileImage: String
    let phoneNum: String
    let gender: String
    let birthDay: String
    let info1: String
    let info2: String
    let info3: String
    let info4: String
    let info5: String
    let followers: [FollowDTO]
    let following: [FollowDTO]
    let posts: [String]
}
