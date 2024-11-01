//
//  AuthView.swift
//  DogWalk
//
//  Created by 소정섭 on 10/31/24.
//

import SwiftUI

struct AuthView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
            VStack {
                VStack(spacing: 15) {
                    Text("반가워요!")
                        .font(.bagelfat28)
                        .foregroundColor(Color.primaryBlack)
                    
                    Text("도그워크와 함께\n즐거운 산책을 시작해볼까요?")
                        .font(.pretendardBlack20)
                        .foregroundColor(Color.primaryBlack)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 60)
                Spacer()

                Image(.test) // 강아지 이미지 에셋 필요
                    .resizable()
                    .frame(width: width/4, height: width/4)
                    .padding(.bottom)
                Spacer()
                
                VStack(spacing: 12) {
                    CommonButton(width: width-width/10, height: width/8, cornerradius: 10, backColor: Color.init(hex: "#FEE500"), text: "KaKao로 시작하기", textFont: .pretendardSemiBold15, textColor: .primaryBlack, leftLogo: Image("kakaotalk_sharing_btn_small"), imageSize: 25)
                    
                    CommonButton(width: width-width/10, height: width/8, cornerradius: 10, backColor: Color.primaryBlack, text: "Apple로 계속하기", textFont: .pretendardSemiBold15, textColor: .primaryWhite, leftLogo: Image(systemName: "apple.logo"), imageSize: 20)
                        .foregroundColor(.primaryWhite)
                }
                .padding(.horizontal, 20)
            }
            .background(Color.primaryLime)
        }
}

#Preview {
    AuthView()
}
