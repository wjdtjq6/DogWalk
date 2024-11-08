//
//  UserManager.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import Foundation

private enum UserDefaultsKeys {
    static let userNick = "userNickname" // 닉네임
    static let lon = "lon" // 위도
    static let lat = "lat" // 경도
    static let roadAddress = "roadAddress" // 도로명 주소
    static let points = "points" // 포인트
    static let totalWalkTime = "totalWalkTime" // 산책시간
    static let postCount = "postCount" // 게시물 작성 횟수
    static let gender = "gender" // 성별
    static let acess = "acess" // acess token
    static let refresh = "refresh" // refresh token
}

final class UserManager {
    static let shared = UserManager()
    private init() {}
    
    @UserDefault(key: UserDefaultsKeys.userNick, defaultValue: "도그워크")
    var userNick: String
    
    @UserDefault(key: UserDefaultsKeys.lon, defaultValue: 0.0)
    var lon: Double
    
    @UserDefault(key: UserDefaultsKeys.lat, defaultValue: 0.0)
    var lat: Double
    
    @UserDefault(key: UserDefaultsKeys.roadAddress, defaultValue: "")
    var roadAddress: String
    
    @UserDefault(key: UserDefaultsKeys.points, defaultValue: 0)
    var points: Int
    
    @UserDefault(key: UserDefaultsKeys.totalWalkTime, defaultValue: 0)
    var totalWalkTime: Int
    
    @UserDefault(key: UserDefaultsKeys.postCount, defaultValue: 0)
    var postCount: Int
    
    @UserDefault(key: UserDefaultsKeys.gender, defaultValue: "")
    var gender: String
    
    @UserDefault(key: UserDefaultsKeys.acess, defaultValue: "")
    var acess: String
    
    @UserDefault(key: UserDefaultsKeys.refresh, defaultValue: "")
    var refresh: String
    
}
