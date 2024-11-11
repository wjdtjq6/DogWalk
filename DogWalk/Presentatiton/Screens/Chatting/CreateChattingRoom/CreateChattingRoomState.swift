//
//  CreateChattingRoomState.swift
//  DogWalk
//
//  Created by junehee on 11/11/24.
//

import Foundation

// 채팅방 생성 관련 데이터/속성 프로토콜
protocol CreateChattingRoomStateProtocol {
    var chattingRooms: [ChatRoomModel] { get }
}

// 채팅방 생성 관련 메서드 프로토콜
protocol CreateChattingRoomActionProtocol: AnyObject {
    
}

// View에 전달할 데이터
@Observable
final class CreateChattingRoomState: CreateChattingRoomStateProtocol, ObservableObject {
    var chattingRooms: [ChatRoomModel] = []
}

// Intent에 넘겨줄 함수
extension CreateChattingRoomState: CreateChattingRoomActionProtocol {
    
}
