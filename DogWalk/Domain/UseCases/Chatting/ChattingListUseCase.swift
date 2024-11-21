//
//  ChattingListUseCase.swift
//  DogWalk
//
//  Created by junehee on 11/19/24.
//

import Foundation

/**
 채팅방 리스트 (채팅 탭)
 */
protocol ChattingListUseCase {
    func getChattingRoomList() async throws -> [ChattingRoomModel]
}

final class DefaultChattingListUseCase: ChattingListUseCase {
    private let network = NetworkManager()
    
    //임시
    private let chatRepository = ChatRepository.shared
    
    // 채팅방 목록 가져오기
    func getChattingRoomList() async throws -> [ChattingRoomModel] {
        print("모든 채팅방 가져왕")
        do {
            let DTO = try await network.requestDTO(target: .chat(.getChatRoomList), of: ChattingRoomListResponseDTO.self)
            return DTO.toDomain()
        } catch {
            print(#function, "채팅방 목록 가져오기 실패")
            throw error
        }
    }
}
