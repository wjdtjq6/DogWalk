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
    
    // 채팅방 목록 가져오기
    func getChattingRoomList() async throws -> [ChattingRoomModel] {
        do {
            let DTO = try await network.requestDTO(target: .chat(.getChatRoomList), of: ChattingRoomListResponseDTO.self)
            return DTO.toDomain()
        } catch {
            print(#function, "채팅방 목록 가져오기 실패")
            throw error
        }
    }
}
