//
//  FollowDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 팔로잉 & 팔로워 응답 (Response)
struct FollowDTO: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
}

extension FollowDTO {
    func toDomain() -> UserModel {
        return UserModel(userID: self.user_id, 
                         nick: self.nick,
                         profileImage: self.profileImage)
    }
}

