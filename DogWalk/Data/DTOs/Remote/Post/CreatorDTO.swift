//
//  CreatorDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 게시글 작성자 응답
struct CreatorDTO: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
}
