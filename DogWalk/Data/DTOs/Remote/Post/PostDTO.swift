//
//  PostDTO.swift
//  DogWalk
//
//  Created by junehee on 11/3/24.
//

import Foundation

// 게시글 상세 응답
struct PostDTO: Decodable {
    let post_id: String
    let category: String
    let title: String
    let price: Int
    let content: String
    let createdAt: String
    let creator: CreatorDTO
    let files: [String]
    let likes: [String]
    let hashTags: [String]
    let comments: [CommentDTO]
    let geolocation: GeolocationDTO
    let distance: Double
}

/**
 `distace`: 요청 쿼리의 위경도인 위치 기준으로 조회된 게시글의 위경도의 위치가 얼마나 떨어져있는지 의미. (미터단위)
 */
