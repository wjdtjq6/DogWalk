//
//  ChattingRoomView.swift
//  DogWalk
//
//  Created by 박성민 on 10/31/24.
//

import SwiftUI

struct ChattingRoomView: View {
    private static let width = UIScreen.main.bounds.width
    private static let height = UIScreen.main.bounds.height
    @State private var text: String = "" //임시 키보드 입력
}

extension ChattingRoomView {
    var body: some View {
        keyBoardView()
    }
}

private extension ChattingRoomView {
    func keyBoardView() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray)
            .frame(width: Self.width * 0.8)
            .frame(minHeight: Self.height * 0.1, maxHeight: Self.height * 0.3)
        
    }
}


#Preview {
    ChattingRoomView()
}
