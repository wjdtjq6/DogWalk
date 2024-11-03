//
//  PostDTO.swift
//  DogWalk
//
//  Created by junehee on 11/2/24.
//

import Foundation

// 게시글 조회 응답
struct PostResponseDTO: Decodable {
    let data: [PostDTO]
    let next_cursor: String
}
