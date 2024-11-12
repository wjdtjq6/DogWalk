//
//  ChattingRoomIntent.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation

protocol ChattingRoomIntentProtocol {
    
}

final class ChattingRoomIntent {
    private weak var state: ChattingRoomActionProtocol?
    
    init(state: ChattingRoomActionProtocol? = nil) {
        self.state = state
    }
}

extension ChattingRoomIntent: ChattingRoomIntentProtocol {
    
}
