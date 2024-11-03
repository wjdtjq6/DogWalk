//
//  CommentDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 게시글 댓글 응답
struct CommentDTO: Decodable {
    let comment_id: String
    let content: String
    let createdAt: String
    let creator: CreatorDTO
}
