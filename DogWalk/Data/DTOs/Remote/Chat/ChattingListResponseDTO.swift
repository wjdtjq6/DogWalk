//
//  ChatRoomResponseDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 채팅방 리스트 조회 응답 (Response)
struct ChattingListResponseDTO: Decodable {
    let data: [ChattingListDTO]
}

extension ChattingListResponseDTO {
    func toDomain() -> [ChattingListModel] {
        return self.data.map { $0.toDomain() }
    }
}
