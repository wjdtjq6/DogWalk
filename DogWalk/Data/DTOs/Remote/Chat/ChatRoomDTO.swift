//
//  ChatRoomDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 채팅방 정보 응답 (Response)
struct ChatRoomDTO: Decodable {
    let room_id: String
    let createdAt: String
    let updatedAt: String
    let participants: [CreatorDTO]
    let lastChat: LastChatDTO
    let files: [String]
}
