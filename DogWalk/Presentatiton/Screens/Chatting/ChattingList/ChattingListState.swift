//
//  ChattingListState.swift
//  DogWalk
//
//  Created by junehee on 11/11/24.
//

import Foundation
import Combine

protocol ChattingListStateProtocol {
    var chattingRoomList: [ChattingListModel] { get }       // 채팅방 목록
}

protocol ChattingListActionProtocol: AnyObject {
    func getChattingRoomList() async
}

@Observable
final class ChattingListState: ChattingListStateProtocol, ObservableObject {
    private let network = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    var chattingRoomList: [ChattingListModel] = []
}

extension ChattingListState: ChattingListActionProtocol {
    // 채팅방 목록 가져오기
    func getChattingRoomList() async {
        do {
            let future = try await network.request(target: .chat(.getChatRoomList), of: ChattingListResponseDTO.self)
            
            future
                .sink { result in
                    switch result {
                    case .finished:
                        print("✨ 채팅방 목록 가져오기 성공")
                    case .failure(let error):
                        print("🚨 채팅방 목록 가져오기 실패", error)
                    }
                } receiveValue: { [weak self] chatRoomList in
                    self?.chattingRoomList = chatRoomList.data.map { $0.toDomain() }
                }
                .store(in: &cancellables)
        } catch {
            print("채팅방 목록 요청 실패", error)
        }
    }
}
