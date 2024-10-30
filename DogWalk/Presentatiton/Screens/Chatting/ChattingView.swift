//
//  ChattingView.swift
//  DogWalk
//
//  Created by 김윤우 on 10/29/24.
//

import SwiftUI

struct ChattingView: View {
    @State private var searchText = "하이"
    var body: some View {
<<<<<<< Updated upstream
        Text("ChattingView")
=======
        VStack {
            HStack {
                Text("MeongTalk")
                       .font(.bagelfat28)
                       .vTop()
                Spacer()
            }
            .padding(.leading, 12)
        }
        .searchable(text: $searchText)
>>>>>>> Stashed changes
    }
}

#Preview {
    ChattingView()
}
