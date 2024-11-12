//
//  CreateChattingRoomView.swift
//  DogWalk
//
//  Created by junehee on 11/11/24.
//

import SwiftUI

// 채팅방 생성 화면
struct CreateChattingRoomView: View {
    @StateObject var container: Container<CreateChattingRoomIntentProtocol, CreateChattingRoomStateProtocol>
    private var state: CreateChattingRoomStateProtocol { container.state }
    private var intent: CreateChattingRoomIntentProtocol { container.intent }
}

extension CreateChattingRoomView {
    static func build() -> some View {
        let state = CreateChattingRoomState()
        let intent = CreateChattingRoomIntent(state: state)
        let container = Container(
            intent: intent as CreateChattingRoomIntentProtocol,
            state: state as CreateChattingRoomStateProtocol,
            modelChangePublisher: state.objectWillChange)
        let view = CreateChattingRoomView(container: container)
        return view
    }
}

extension CreateChattingRoomView {
    var body: some View {
        Text("채팅방 생성 화면")
    }
}
