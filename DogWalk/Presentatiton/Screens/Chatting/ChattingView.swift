    //
//  ChattingView.swift
//  DogWalk
//
//  Created by 김윤우 on 10/29/24.
//

import SwiftUI

struct TestData: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var chat: String
    
    init(name: String = "멋쟁이 윤우", chat: String = "제일 좋아하는 건~~~~ 유킷, 스유, mvvm, mvi, tca, 렛츠고") {
        self.name = name
        self.chat = chat
    }
}

struct ChattingView: View {
    @State private var searchText = ""
    @State private var items = Array(repeating: TestData(), count: 10) // 테스트 데이터 배열, 실제 데이터로 변경
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(items, id: \.self) { item in
                        chattingViewCell(item)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "검색") // SearchBar
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    appLogo() // 좌상단 앱 로고
                }
            }
        }
    }
    
    // 채팅방 Cell
    func chattingViewCell(_ item: TestData) -> some View {
        // 임시로 SettingView로 해놨습니다. 추후에 채팅 디테일로 바꿔야 돼요
        NavigationLink {
            SettingView()
        } label: {
            HStack {
                // 프로필 사진 클릭시
                Button {
                    print("ChattingListView ProfileImage 클릭")
                } label: {
                    CommonProfile(image: .asTestImage, size: 60)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name) // 이름
                        .font(.pretendardBold18)
                        .foregroundColor(.primaryBlack)
                    Text(item.chat) // 내용
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.pretendardRegular12)
                    
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("20:53")
                    .font(.pretendardRegular14)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }
    }
    
    // 좌상단 앱 로고
    func appLogo() -> some View {
        HStack {
            Text("MeongTalk")
                .font(.bagelfat28)
            Spacer()
        }
    }
}

#Preview {
    ChattingView()
}
