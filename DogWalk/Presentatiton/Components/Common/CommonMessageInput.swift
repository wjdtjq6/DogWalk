//
//  CommonMessageInput.swift
//  DogWalk
//
//  Created by 박성민 on 10/31/24.
//

import SwiftUI

struct CommonMessageInput: View {
    @State private var newMessage = ""
    var body: some View {
        keyboard()
            .padding(.horizontal)
            .padding(.bottom, 5)
        
    }
}
private extension CommonMessageInput {
    func keyboard() -> some View {
        HStack {
            Circle()
                .frame(width: 30)
                .foregroundStyle(.gray)
                .overlay(
                    Image.asPlus
                        .resizable()
                        .frame(width: 20, height: 20)

                )
                .vBottom()
                .padding(.bottom, 1)
                
            TextField("메시지 입력", text: $newMessage, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5)
                .frame(minHeight: 30)
                .submitLabel(.return)
                .vBottom()
            CommonButton(width: 50, height: 30,
                         cornerradius: 10, backColor: Color.primaryGreen,
                         text: "🐾", textFont: .pretendardBold14)
            .vBottom()
        }
        
        
    }
}

#Preview {
    CommonMessageInput()
}
