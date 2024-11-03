//
//  LastChatDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 마지막 채팅 정보 응답 (Response)
struct LastChatDTO: Decodable {
    let chat_id: String
    let room_id: String
    let content: String
    let sender: CreatorDTO
}
