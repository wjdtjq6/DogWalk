//
//  CommunityState.swift
//  DogWalk
//
//  Created by 박성민 on 11/12/24.
//

import Foundation

// MARK: - 데이터 관련 프로토콜
protocol CommunityStateProtocol { // 속성들을 가지는 프토코롤
    var contentState: CommunityContentState { get } // 뷰 상태
    var postList: [PostModel] { get } //게시글들
    var categorys: [CommunityCategoryType] { get } //필터 버튼
    var selectCategory: CommunityCategoryType { get } // 선택한 필터
    var userArea: String { get } // 유저가 선택한 위치
}

protocol CommunityActionProtocol: AnyObject { //메서드을 가지고있는 프로토콜
    func getPosts(_ posts: [PostModel]) //게시글
    func changeSelectCategory(_ select: CommunityCategoryType) //카테고리 변경
    func changeArea(_ area: String) //위치 설정
}
// MARK: - view에게 전달할 데이터
@Observable
final class CommunityState: CommunityStateProtocol, ObservableObject {
    var contentState: CommunityContentState = .loading
    var postList: [PostModel] = []
    var categorys: [CommunityCategoryType] = CommunityCategoryType.allCases
    var selectCategory: CommunityCategoryType = .all
    var userArea: String = UserManager.shared.roadAddress
}

// MARK: - intent에 줄 함수
extension CommunityState: CommunityActionProtocol {
    func changeSelectCategory(_ select: CommunityCategoryType) {
        self.selectCategory = select
    }
    
    func getPosts(_ posts: [PostModel]) {
        self.postList = posts
    }
    func changeArea(_ area: String) {
        self.userArea = area
    }
}


