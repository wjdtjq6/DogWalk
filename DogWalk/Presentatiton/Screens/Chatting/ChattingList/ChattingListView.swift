//
//  ChattingView.swift
//  DogWalk
//
//  Created by 김윤우 on 10/29/24.
//

import SwiftUI
import Combine

struct TestData: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var chat: String
    var lastChatTime: String
    
    init(name: String = "멋쟁이 윤우", chat: String = "제일 좋아하는 건~~~~ 유킷, 스유, mvvm, mvi, tca, 렛츠고", lastChatTime: String = "20:53") {
        self.name = name
        self.chat = chat
        self.lastChatTime = lastChatTime
    }
}

struct ChattingListView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var searchText = ""
    // @State private var items = (0..<10).map { _ in TestData() } // 테스트 데이터 배열, 실제 데이터로 변경
    // @State private var chattingRoomList: [ChatRoomModel] = []
    
    private let networkManager = NetworkManager()
    
    @StateObject var container: Container<ChattingListIntentProtocol, ChattingListStateProtocol>
    private var state: ChattingListStateProtocol { container.state }
    private var intent: ChattingListIntentProtocol { container.intent }
}

extension ChattingListView {
    static func build() -> some View {
        let state = ChattingListState()
        let intent = ChattingListIntent(state: state)
        let container = Container(
            intent: intent as ChattingListIntentProtocol,
            state: state as ChattingListStateProtocol,
            modelChangePublisher: state.objectWillChange
        )
        let view = ChattingListView(container: container)
        return view
    }
}

extension ChattingListView {
    var body: some View {
        NavigationView {
            ScrollView {
                chattingListView()
            }
            .searchable(text: $searchText, prompt: "검색") // SearchBar
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CommonTitleView(title: "MeongTalk") // 좌상단 앱 로고
                }
            }
            .toolbar(.visible, for: .tabBar)
        }
        .task {
            await intent.onAppearTrigger()
        }
    }
    
    // 채팅방 목록
    private func chattingListView() -> some View {
        ForEach(state.chattingRoomList, id: \.roomID) { item in
            chattingViewCell(item)
        }
    }
    
    // 채팅방 Cell
    private func chattingViewCell(_ item: ChatRoomModel) -> some View {
        Button {
            coordinator.push(.chattingRoom)
        } label: {
            HStack {
                CommonProfile(image: .asTestImage, size: 60)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.otherUser.nick) // 이름
                        .font(.pretendardBold18)
                        .foregroundColor(.primaryBlack)
                    Text((item.lastChat?.type == .image ? "사진" : item.lastChat?.lastChat) ?? "") // 내용
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.pretendardRegular12)
                    
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Text(item.updatedAt.getFormattedDateString(.dash))
                    .font(.pretendardRegular14)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
}
