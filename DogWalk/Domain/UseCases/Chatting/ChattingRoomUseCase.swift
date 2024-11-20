//
//  ChattingRoomUseCase.swift
//  DogWalk
//
//  Created by junehee on 11/19/24.
//

import Foundation
import CoreData

/**
 채팅방
 `getCursorDate` DB에서 최신 대화 날짜 가져오기
 `getChattingData` cursor-date 기반 최신 대화 내용 요청
 `updateChattingData`  응답 받은 최신 대화 내용을 DB에 업데이트
 */
protocol ChattingRoomUseCase {
    func getCursorDate() -> String
    func getChattingData(roomID: String, cursorDate: String) async throws -> [ChattingModel]
    func updateChattingData(_ data: [ChattingModel])
    func getAllChattingData() -> [ChattingModel]
}

final class DefaultChattingRoomUseCase: ChattingRoomUseCase {
    private let network = NetworkManager()
    private let chatRepository = ChatRepository(context: CoreDataManager().viewContext)
    
    // DB에서 최신 대화 날짜 가져오기
    func getCursorDate() -> String {
        // chatRepository.fetchMessages(in: <#T##ChatRoom#>)
        return ""
    }
    
    // cursor_date 기반 최신 대화 내용 요청
    func getChattingData(roomID: String, cursorDate: String) async throws -> [ChattingModel] {
        do {
            let query = GetChatListQuery(cursor_date: cursorDate)
            let DTO = try await network.requestDTO(target: .chat(.getChatList(roomId: roomID, query: query)), of: ChattingResponseDTO.self)
            return DTO.toDomain()
        } catch {
            print(#function, "최신 대화 요청 실패")
            throw error
        }
    }
    
    // 응답 받은 최신 대화 내용을 DB에 업데이트
    func updateChattingData(_ data: [ChattingModel]) {
        // DB에 업데이트 하고
        // chatRepository.updateLastChat(chatRoomData: <#T##ChattingRoomModel#>)
    }
    
    // DB에서 전체 대화 내용을 가져와 View 반영
    func getAllChattingData() -> [ChattingModel] {
        return []
    }
}
