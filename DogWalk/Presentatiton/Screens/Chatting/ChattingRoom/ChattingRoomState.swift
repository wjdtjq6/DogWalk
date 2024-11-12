//
//  ChattingRoomState.swift
//  DogWalk
//
//  Created by junehee on 11/12/24.
//

import Foundation

protocol ChattingRoomStateProtocol {
    
}

protocol ChattingRoomActionProtocol: AnyObject {
    
}

@Observable
final class ChattingRoomState: ChattingRoomStateProtocol, ObservableObject {
    
}

extension ChattingRoomState: ChattingRoomActionProtocol {
    
}
