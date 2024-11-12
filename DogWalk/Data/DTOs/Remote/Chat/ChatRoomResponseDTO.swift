//
//  ChatRoomResponseDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 채팅방 리스트 조회 응답 (Response)
struct ChatRoomResponseDTO: Decodable {
    let data: [ChatRoomDTO]
}

extension ChatRoomResponseDTO {
    func toDomain() -> [ChatRoomModel] {
        return self.data.map { $0.toDomain() }
    }
}
