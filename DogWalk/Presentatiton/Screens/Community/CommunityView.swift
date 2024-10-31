//
//  CommunityView.swift
//  DogWalk
//
//  Created by junehee on 10/30/24.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        // 상세 화면 확인용 테스트 버튼입니다!
        NavigationView {
            NavigationLink {
                CommunityDetailView()
            } label: {
                Text("상세화면 테스트")
            }
        }
    }
}

#Preview {
    CommunityCreateView()
}
