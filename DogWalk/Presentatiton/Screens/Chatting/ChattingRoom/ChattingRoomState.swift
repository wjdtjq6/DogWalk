//
//  ChattingRoomState.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation
import Combine

protocol ChattingRoomStateProtocol {
    var chattingData: [ChattingRoomModel] { get }       // 채팅방 채팅 내역
}

protocol ChattingRoomActionProtocol: AnyObject {
    func getChattingData(roomID: String) async
    func sendTextMessage(roomID: String, message: String) async
}

@Observable
final class ChattingRoomState: ChattingRoomStateProtocol, ObservableObject {
    private let network = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    var chattingData: [ChattingRoomModel] = []
}

extension ChattingRoomState: ChattingRoomActionProtocol {
    // 채팅방 채팅 내역 가져오기
    func getChattingData(roomID: String) async {
        print("채팅방 대화 내역 가져오기")
        do {
            let query = GetChatListQuery(cursor_date: "")
            let future = try await network.request(target: .chat(.getChatList(roomId: roomID, query: query)), of: ChattingRoomResponseDTO.self)
            
            future
                .sink { result in
                    switch result {
                    case .finished:
                        print("✨ 채팅 내역 가져오기 성공")
                    case .failure(let error):
                        print("🚨 채팅방 목록 가져오기 실패", error)
                    }
                } receiveValue: { [weak self] chattingList in
                    print(chattingList)
                    self?.chattingData = chattingList.data.map { $0.toDomain() }
                }
                .store(in: &cancellables)
        } catch {
            print("채팅 내역 요청 실패", error)
        }
    }
    
    // 채팅방에서 채팅 전송하기 (텍스트)
    func sendTextMessage(roomID: String, message: String) async {
        print("채팅 전송하기 시작")
        do {
            let body = SendChatBody(content: message, files: [])
            let future = try await network.request(target: .chat(.sendChat(roomId: roomID, body: body)), of: LastChatDTO.self)
            
            future
                .sink { result in
                    switch result {
                    case .finished:
                        print("✨ 채팅 전송 성공")
                    case .failure(let error):
                        print("🚨 채팅 전송 실패", error)
                    }
                } receiveValue: { chatData in
                    print(chatData)
                }
                .store(in: &cancellables)
        } catch {
            print("채팅 전송 요청 실패", error)
        }
    }
}
