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
 `getAllChattingData` DB에 저장된 대화 내용 전체 가져오기
 `openSocket` 소켓 연결
 `sendMessage` 메세지 전송
 `closeSocket` 소켓 해제
 */
protocol ChattingRoomUseCase {
    func getCursorDate(roomID: String) -> String
    func getChattingData(roomID: String, cursorDate: String) async throws -> [ChattingModel]
    func updateChattingData(roomID: String, data: [ChattingModel])
    func getAllChattingData() -> [ChattingModel]
    func openSocket(roomID: String)
    func sendTextMessage(roomID: String, message: String) async throws -> ChattingModel
    func sendImageMessage(roomID: String, image: Data) async throws -> ChattingFilesModel
    func closeSocket()
}

final class DefaultChattingRoomUseCase: ChattingRoomUseCase {
    private let network = NetworkManager()
    private var socket: SocketIOManager?
    private let chatRepository = ChatRepository(context: CoreDataManager().viewContext)
    
    // DB에서 최신 대화 날짜 가져오기
    func getCursorDate(roomID: String) -> String {
        let room = chatRepository.fetchChatRoom(chatRoomID: roomID)
        guard let updateAt = room?.updatedAt else { return "" }
        print("UpdateAt", updateAt)
        return updateAt
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
    func updateChattingData(roomID: String, data: [ChattingModel]) {
        // DB에 업데이트 하고
        guard let chatRoom = chatRepository.fetchChatRoom(chatRoomID: roomID) else { return }
        let messages = data.map { msg in
            chatRepository.createChatMessage(chatID: msg.chatID,
                                             content: msg.content,
                                             sender: msg.sender,
                                             in: chatRoom)
        }
        // chatRepository.updateChatMessages(messages: messages)
        chatRepository.updateChatRoom(chatRoomID: roomID, newMessages: messages, context: chatRoom.managedObjectContext!)
    }
    
    // DB에서 전체 대화 내용을 가져와 View 반영
    func getAllChattingData() -> [ChattingModel] {
        return []
    }
    
    // 소켓 열기
    func openSocket(roomID: String) {
        let socket = SocketIOManager(roomID: roomID)
        socket.connect()
    }
    
    // 텍스트 보내기
    func sendTextMessage(roomID: String, message: String) async throws  -> ChattingModel {
        do {
            let body = SendChatBody(content: message)
            let DTO = try await network.requestDTO(target: .chat(.sendChat(roomId: roomID, body: body)), of: ChattingDTO.self)
            return DTO.toDomain()
        } catch {
            print(#function, error)
            throw error
        }
    }
    
    // 이미지 보내기
    func sendImageMessage(roomID: String, image: Data) async throws -> ChattingFilesModel {
        do {
            let body = PostFileBody(files: [image])
            let data = try await network.requestDTO(target: .chat(.postChatFiles(roomId: roomID, body: body)), of: ChattingFilesModel.self)
            return data
        } catch {
            print(#function, error)
            throw error
        }
    }
    
    // 소켓 닫기
    func closeSocket() {
        socket?.disconnect()
    }
}
