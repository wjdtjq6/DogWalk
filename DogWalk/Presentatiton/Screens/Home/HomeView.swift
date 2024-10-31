//
//  HomeView.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import SwiftUI

struct HomeView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.teal
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: height/2)
            VStack {
                VStack(alignment: .leading) {
                    Text("산책 가방 어디써? 빨리 나가자")//prompt
                        .font(.pretendardSemiBold30)
                        .padding(.vertical,1)
                    VStack(alignment: .leading) {
                        Text("위치 · 문래동6가")//위치
                            .padding(.vertical,1)
                        Text("날씨 · 흐림")//날씨
                    }
                    .font(.pretendardRegular17)
                    .foregroundColor(.gray)
                }
                .padding(10)
                .frame(maxWidth: width*2/3, alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: height/2, alignment: .topLeading)
                  
            Image(.test)
                .resizable()
                .frame(width: 300, height: 300)
                .frame(maxWidth: .infinity, maxHeight: height/2, alignment: .bottomTrailing)
        }
        
        HStack {
            Text("산책")
            Text("산책")
        }
    }
}

#Preview {
    HomeView()
}
