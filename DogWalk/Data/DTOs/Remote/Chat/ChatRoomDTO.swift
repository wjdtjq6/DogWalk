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
    let participants: [UserDTO]
    let lastChat: LastChatDTO
}

extension ChatRoomDTO {
    func toDomain() -> ChatRoomModel {
        let userID = "" // UserDefaults에 저장된 값 가져오기
        let me = self.participants.first { $0.user_id == userID } ?? UserDTO(user_id: "", nick: "", profileImage: "")
        let otherUser = self.participants.first { $0.user_id != userID } ?? UserDTO(user_id: "", nick: "", profileImage: "")    // 사용자가 2명 이상일 경우 변경 필요
        
        return ChatRoomModel(roomID: self.room_id,
                             createAt: self.createdAt.getFormattedDateString(.dot),  // TODO: 날짜 포맷팅 처리 로직 확인 필요
                             updatedAt: self.updatedAt.getFormattedDateString(.dot), // TODO: 날짜 포맷팅 처리 로직 확인 필요
                             me: me.toDomain(),
                             otherUser: otherUser.toDomain(),
                             lastChat: self.lastChat.toDomain())
    }
}

// 실제 사용할 모델
struct ChatRoomModel {
    let roomID: String                  // 채팅방 ID
    let createAt: String                // 채팅방 생성일
    let updatedAt: String               // 채팅방 수정일 (마지막 메세지)
    let me: UserModel                   // 나
    let otherUser: UserModel            // 상대방 (채팅방 참여자)
    let lastChat: LastChatModel         // 마지막 채팅 정보
}
