//
//  ChattingRoomResponseDTO.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation

// 채팅 내역 조회 응답 (Response)
struct ChattingRoomResponseDTO: Decodable {
    let data: [ChattingRoomDTO]
}

extension ChattingRoomResponseDTO {
    func toDomain() -> [ChattingRoomModel] {
        return self.data.map { $0.toDomain() }
    }
}
