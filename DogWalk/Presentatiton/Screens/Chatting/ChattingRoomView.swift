//
//  ChattingRoomView.swift
//  DogWalk
//
//  Created by 박성민 on 10/31/24.
//

import SwiftUI

struct ChattingRoomView: View {
    private static let width = UIScreen.main.bounds.width
    private static var height = UIScreen.main.bounds.height
    @State private var text: String = "" //임시 키보드 입력
}

extension ChattingRoomView {
    var body: some View {
        VStack {
            ZStack {
                GeometryReader {
                    //키보드
                    CommonSendView(proxy: $0) { text in
                        print(text) // 보낼 경우 텍스트 반환
                    }
                }
            }
            .ignoresSafeArea()
            .background(Color.primaryWhite)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        
    }
}

// MARK: - 채팅 내역 부분
private extension ChattingRoomView {
}


#Preview {
    ChattingRoomView()
}

extension View {
    func tabBarHidden(_ hidden: Bool) -> some View {
        self.toolbar(hidden ? .hidden : .visible, for: .tabBar)
    }
}
