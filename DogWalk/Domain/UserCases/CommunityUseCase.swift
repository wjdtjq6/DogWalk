//
//  CommunityUseCase.swift
//  DogWalk
//
//  Created by 박성민 on 11/12/24.
//

import Foundation
import Combine

enum CheckPostType {
    case userLocation
    case all
    
    var title: String {
        switch self {
        case .userLocation:
            return UserManager.shared.roadAddress
        case .all:
            return "전국"
        }
    }
}
protocol CommunityUseCase {
    func changePostType(postType: CheckPostType, isPaging: Bool) async throws -> [PostModel]
    func changeCategory(category: CommunityCategoryType, isPaging: Bool) async throws -> [PostModel]
    func getPosts(isPaging: Bool) async throws -> [PostModel]
}
// MARK: - 실제 앱에 사용할 UseCase
final class DefaultCommunityUseCase: CommunityUseCase {
    private let network = NetworkManager()
    private let userManager = UserManager.shared
    private var checkPostType: CheckPostType
    private var category: CommunityCategoryType
    init(checkPostType: CheckPostType, category: CommunityCategoryType) {
        self.checkPostType = checkPostType
        self.category = category
    }
    func changePostType(postType: CheckPostType, isPaging: Bool) async throws -> [PostModel] {
        self.checkPostType = postType
        return try await self.getPosts(isPaging: isPaging)
    }
    func changeCategory(category: CommunityCategoryType, isPaging: Bool) async throws -> [PostModel] {
        self.category = category
        return try await self.getPosts(isPaging: isPaging)
    }
    
}
extension DefaultCommunityUseCase {
    func getPosts(isPaging: Bool) async throws -> [PostModel] {
        do {
            switch checkPostType {
            case .all:
                let future = try await network.fetchPosts(category: [self.category.rawValue], isPaging: isPaging)
                let posts = try await future.value
                return posts.data.map { $0.toDomain() }
            case .userLocation:
                let future = try await network.fetchAreaPosts(category: [self.category.rawValue], lon: String(userManager.lon), lat: String(userManager.lat))
                let posts = try await future.value
                return posts.map{ $0.toDomain() }
                
            }
        } catch {
            guard let  err = error as? NetworkError else { throw error}
            throw err
        }
    }
}

// MARK: - 테스트를 ㅇ
final class MockCommunityUseCase: CommunityUseCase {
    func changePostType(postType: CheckPostType, isPaging: Bool) async throws -> [PostModel] {
        <#code#>
    }
    
    func changeCategory(category: CommunityCategoryType, isPaging: Bool) async throws -> [PostModel] {
        <#code#>
    }
    
    func getPosts(isPaging: Bool) async throws -> [PostModel] {
        <#code#>
    }
    
    
}
