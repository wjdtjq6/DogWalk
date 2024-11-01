//
//  CommunityTopicSelectedView.swift
//  DogWalk
//
//  Created by junehee on 10/31/24.
//

import SwiftUI

// 게시물 카테고리
enum CommunityCategory: String, CaseIterable {
    case all = "전체보기"
    case walkCertification = "산책인증"
    case question = "궁금해요"
    case shop = "중고용품"
    case sitter = "펫시터 구하기"
    case free = "자유게시판"
}

struct CommunityCategorySelectedView: View {
    private let count = CommunityCategory.allCases.count
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        ForEach(CommunityCategory.allCases, id: \.self) { topic in
            Button(action: {
                print("선택한 카테괴리: ", topic.rawValue)
            }, label: {
                CommonButton(width: width * 0.8, height: 50,
                             cornerradius: 20, backColor: Color.primaryLime,
                             text: topic.rawValue, textFont: .pretendardSemiBold16)

            })
        }
    }
}

#Preview {
    CommunityCategorySelectedView()
}
