//
//  UserManager.swift
//  DogWalk
//
//  Created by junehee,김윤우 on 10/29/24.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    private init() {}
    
    @UserDefault(key: .isUser, defaultValue: false)
    var isUser: Bool
    
    @UserDefault(key: .userID, defaultValue: "")
    var userID: String
    
    @UserDefault(key: .userNick, defaultValue: "도그워크")
    var userNick: String
    
    @UserDefault(key: .lon, defaultValue: 0.0)
    var lon: Double
    
    @UserDefault(key: .lat, defaultValue: 0.0)
    var lat: Double
    
    @UserDefault(key: .roadAddress, defaultValue: "")
    var roadAddress: String
    
    @UserDefault(key: .points, defaultValue: 0)
    var points: Int
    
    @UserDefault(key: .totalWalkTime, defaultValue: 0)
    var totalWalkTime: Int
    
    @UserDefault(key: .postCount, defaultValue: 0)
    var postCount: Int
    
    @UserDefault(key: .gender, defaultValue: "")
    var gender: String
    
    @UserDefault(key: .acess, defaultValue: "")
    var acess: String
    
    @UserDefault(key: .refresh, defaultValue: "")
    var refresh: String
    
    @UserDefault(key: .imageCache, defaultValue: ["":""])
    var imageCache: [String: String]
}
