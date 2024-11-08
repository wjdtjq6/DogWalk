//
//  UserManager.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    private init() {}
    
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
    
    @UserDefault(key: .acess, defaultValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTE1YjExOTc0ODhmOTBkM2U3ZTZlNSIsImlhdCI6MTcxMjQxMzgyMiwiZXhwIjoxNzEyNzczODIyLCJpc3MiOiJzZXNhY18zIn0.fYNU0m-3oilabkh-MP65OKwTkFHkpqSGigQG5YbHuWE")
    var acess: String
    
    @UserDefault(key: .refresh, defaultValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTE1YjExOTc0ODhmOTBkM2U3ZTZlNSIsImlhdCI6MTcxMjQxMzgyMiwiZXhwIjoxNzE2MDEzODIyLCJpc3MiOiJzZXNhY18zIn0.VvA9hxyCUHfp-RgBNgCsCu6VDdD3kXEJfgzuiRXlkuQ")
    var refresh: String
}
