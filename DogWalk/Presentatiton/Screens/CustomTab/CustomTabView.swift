//
//  CustomTabView.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image.asWalk
                        .renderingMode(.template)
                    Text("홈")
                }
            MapView()
                .tabItem {
                    Image.asWalk
                        .renderingMode(.template)
                    Text("산책하기")
                }
            CommunityView()
                .tabItem {
                    Image.asWalk
                        .renderingMode(.template)
                    Text("커뮤니티")
                }
            ChattingListView.build()
                .tabItem {
                    Image.asWalk
                        .renderingMode(.template)
                    Text("멍톡")
                }
        }
        .tint(Color.primaryGreen)
    }
}

#Preview {
    CustomTabView()
}
