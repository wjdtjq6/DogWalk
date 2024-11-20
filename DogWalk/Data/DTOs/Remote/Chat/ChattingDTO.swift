//
//  ChattingDTO.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation

// 채팅 내역 응답 (Response)
// 특정 채팅방에서 대화한 채팅 1개에 대한 정보
struct ChattingDTO: Decodable {
    let chat_id: String
    let room_id: String
    let content: String?
    let sender: UserDTO
    let files: [String]
}

extension ChattingDTO {
    func toDomain() -> ChattingModel {
        let messageType: MessageType = self.content == nil ? .image : .text
        return ChattingModel(chatID: self.chat_id,
                                 roomID: self.room_id,
                                 type: messageType,
                                 content: self.content ?? "",
                                 sender: UserModel(userID: self.sender.user_id,
                                                   nick: self.sender.nick,
                                                   profileImage: self.sender.profileImage ?? ""),
                                 files: self.files)
    }
}

struct ChattingModel: Equatable, Identifiable {
    static func == (lhs: ChattingModel, rhs: ChattingModel) -> Bool {
        return false
    }
    
    let id = UUID()
    let chatID: String                  // 채팅 ID
    let roomID: String                  // 채팅방 ID
    let type: MessageType               // 채팅 내용이 텍스트인지 사진인지
    let content: String                 // 채팅 내용
    let sender: UserModel               // 채팅 보낸 사람
    let files: [String]                 // 마지막 채팅 정보
}
