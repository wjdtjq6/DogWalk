//
//  CreateChattingRoomIntent.swift
//  DogWalk
//
//  Created by junehee on 11/11/24.
//

import Foundation

protocol CreateChattingRoomIntentProtocol: AnyObject {
    func createButtonTap()
}

final class CreateChattingRoomIntent {
    private weak var state: CreateChattingRoomActionProtocol?   // Action Protocol 준수!
    
    init(state: CreateChattingRoomActionProtocol) {
        self.state = state
    }
}

extension CreateChattingRoomIntent: CreateChattingRoomIntentProtocol {
    func createButtonTap() {
        print("채팅방 만들기 버튼 클릭")
    }
}
