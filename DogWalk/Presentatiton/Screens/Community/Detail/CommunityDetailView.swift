//
//  CommunityDetailView.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import SwiftUI

struct CommunityDetailView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                communityContentView()
            }
        }
        .navigationTitle("산책 인증")   // 상위뷰에서 카테고리명 데이터 필요
    }
    
    
    private func communityContentView() -> some View {
        VStack {
            // 게시물 제목
            Text("우리 강아지 오늘 산책 2시간하고 개뻗음ㅋㅋㅋㅋㅋ 진짜 개웃김 웃겨 죽음 으캬캬")
                .frame(maxWidth: .infinity)
                .frame(minHeight: 50)
                .multilineTextAlignment(.leading)
                .font(Font.pretendardBold16)
                // .background(.blue.opacity(0.5))
            
            // 프로필 + 닉네임 + 게시물 작성일
            HStack {
                Image(.testProfile)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("머니만듀")
                    .font(.pretendardBold14)
                Spacer()
                Text("2024. 10. 29")
                    .font(.pretendardRegular12)
                    .foregroundStyle(Color.primaryBlack.opacity(0.5))
            }
            .frame(minHeight: 30)
            .padding(.bottom, 10)
            
            // 게시물 내용 예시
            Text("오늘 우리 댕댕이랑 완전 행복한 산책 다녀왔어 🐶💕 맑은 하늘 아래서 시원한 바람 맞으면서 걸으니까 기분이 최고였어 🌞🌬️ 우리 강아지도 신나서 꼬리 살랑살랑 흔들며 여기저기 탐험하느라 바빴다구 🐾🌿 중간에 잠깐 멈춰서 사진도 찍고 📸🌸 맛있는 간식도 먹으면서 여유롭게 즐겼어 🥪🍗 하루 종일 스트레스가 확 날아가는 기분이었어 😌✨ 다음번 산책도 벌써 기대된다앙!!!! 💖🚶‍♀️\n\n처음엔 조금 쌀쌀했지만, 걷다 보니 기분 좋게 몸도 따뜻해지더라구 🌬️❄️ 우리 댕댕이도 추운 날씨에 맞춰 귀여운 옷 입혀서 데리고 나갔는데, 지나가는 사람들마다 귀엽다고 칭찬해줘서 뿌듯했어 🐕🧥💕 그리고 공원에 도착하니까 나뭇잎이 알록달록하게 물들어 있어서 진짜 예뻤어 🍂🍁 여기저기 사진 찍느라 시간 가는 줄도 몰랐다니까 📸🌳")
                .font(.pretendardRegular14)
                .lineSpacing(4)
            
            // 게시물 사진 예시
            AsyncImage(url: URL(string: "https://static.cdn.soomgo.com/upload/portfolio/70bef49e-f3fc-4718-a61f-9613c51cdbf7.jpeg?webp=1")) { image in
                image.image?.resizable().aspectRatio(contentMode: .fit)
            }
            .padding(.top, 10)
            
            // 댓글 이모지 + 카운트
            HStack {
                Image.asMessage
                Text(Int.random(in: 0...100).formatted())
                    .font(.pretendardSemiBold16)
            }
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommunityDetailView()
}
