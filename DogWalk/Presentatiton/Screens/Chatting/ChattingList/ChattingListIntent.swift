//
//  ChattingListIntent.swift
//  DogWalk
//
//  Created by junehee on 11/11/24.
//

import Foundation

protocol ChattingListIntentProtocol {
    func onAppearTrigger() async
}

final class ChattingListIntent {
    private weak var state: ChattingListActionProtocol?
    
    init(state: ChattingListActionProtocol) {
        self.state = state
    }
}

extension ChattingListIntent: ChattingListIntentProtocol {
    func onAppearTrigger() async {
        print(#function, "멍톡 화면 진입")
        await state?.getChattingRoomList()
    }
}
