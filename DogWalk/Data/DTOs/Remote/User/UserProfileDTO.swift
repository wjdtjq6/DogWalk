//
//  UserProfileDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 다른 유저 프로필 조회 응답 (Response)
// email, phoneNum, gender, birthDay 값은 응답값에 포함X
struct UserProfileDTO: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
    let info1: String
    let info2: String
    let info3: String
    let info4: String
    let info5: String
    let followers: [FollowDTO]
    let following: [FollowDTO]
    let posts: [String]
}
