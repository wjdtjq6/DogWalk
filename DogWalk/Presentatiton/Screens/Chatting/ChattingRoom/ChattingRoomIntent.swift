//
//  ChattingRoomIntent.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation

protocol ChattingRoomIntentProtocol {
    func onAppearTrigger(roomID: String) async
    func sendTextMessage(roomID: String, message: String) async
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
    
    func sendTextMessage(roomID: String, message: String) async {
        print(#function, "채팅 전송 버튼 클릭")
        await state?.sendTextMessage(roomID: roomID, message: message)
    }
}
