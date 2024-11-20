//
//  SocketDMDTO.swift
//  DogWalk
//
//  Created by junehee on 11/18/24.
//

import Foundation

// 채팅 소켓 응답 (Response)
struct SocketDMDTO: Decodable {
    let dm_id: Int
    let room_id: Int
    let content: String
    let createAt: String
    let files: [String]
    let user: UserDTO
}

extension SocketDMDTO {
    func toDomain() -> SocketDMModel {
        return SocketDMModel(dmID: self.dm_id,
                             roomID: self.room_id,
                             content: self.content,
                             createdAt: self.createAt,
                             files: self.files,
                             user: UserModel(userID: self.user.user_id,
                                             nick: self.user.nick,
                                             profileImage: self.user.profileImage ?? ""))
    }
}

struct SocketDMModel {
    let dmID: Int
    let roomID: Int
    let content: String
    let createdAt: String
    let files: [String]
    let user: UserModel
}

/* 응답 예시
    {
      "dm_id": 1,
      "room_id": 1,
      "content": "반갑습니다.",
      "createdAt": "2024-10-21T22:47:30.236Z",
      "files": [
        "/static/dms/1701706651157.gif",
        "/static/dms/1701706651161.jpeg",
        "/static/dms/1701706651166.jpeg"
      ],
      "user": {
        "user_id": 1,
        "email": "sesac@gmail.com",
        "nickname": "새싹",
        "profileImage": "/static/profiles/1701706651161.jpeg"
      }
    }
*/
