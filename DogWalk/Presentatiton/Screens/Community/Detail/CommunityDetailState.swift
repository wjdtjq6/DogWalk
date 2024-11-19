//
//  CommunityDetailState.swift
//  DogWalk
//
//  Created by 박성민 on 11/19/24.
//

import Foundation

// MARK: - 데이터 관련 프로토콜
protocol CommunityDetailStateProtocol { // 속성들을 가지는 프토코롤
}

protocol CommunityDetailActionProtocol: AnyObject { //메서드을 가지고있는 프로토콜
}
// MARK: - view에게 전달할 데이터
@Observable
final class CommunityDetailState: CommunityDetailStateProtocol, ObservableObject {
    var contentState: ContentState = .loading
    
    //var errTitle: String = "" //에러 얼럿
}

// MARK: - intent에 줄 함수
extension CommunityDetailState: CommunityDetailActionProtocol {
    
}

