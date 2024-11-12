//
//  ChattingRoomIntent.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation

protocol ChattingRoomIntentProtocol {
    func onAppearTrigger(roomID: String) async
}

final class ChattingRoomIntent {
    private weak var state: ChattingRoomActionProtocol?
    
    init(state: ChattingRoomActionProtocol? = nil) {
        self.state = state
    }
}

extension ChattingRoomIntent: ChattingRoomIntentProtocol {
    func onAppearTrigger(roomID: String) async {
        print(#function, "멍톡 채팅방 진입")
        await state?.getChattingData(roomID: roomID)
    }
}
