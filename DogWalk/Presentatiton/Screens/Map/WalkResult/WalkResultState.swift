//
//  WalkResultState.swift
//  DogWalk
//
//  Created by 박성민 on 11/6/24.
//

import Foundation

// MARK: - 데이터 관련 프로토콜
protocol WalkResultStateProtocol { // 속성들을 가지는 프토코롤
    var isPresented: Bool { get }
    
    var postDate: String { get }
    var dogNick: String { get }
    var userProfile: String { get }
    
    var walkTime: String { get }
    var walkDistance: String { get }
    var walkCalorie: String { get }
}

protocol WalkResultActionProtocol: AnyObject { //메서드을 가지고있는 프로토콜
    
}
// MARK: - view에게 전달할 데이터
@Observable
final class WalkResultState: WalkResultStateProtocol, ObservableObject {
    var isPresented: Bool = false
    
    var postDate: String  = ""
    var dogNick: String = ""
    var userProfile: String = ""
    
    var walkTime: String = ""
    var walkDistance: String = ""
    var walkCalorie: String = ""
}

// MARK: - intent에 줄 함수
extension WalkResultState: WalkResultActionProtocol {
    
}
