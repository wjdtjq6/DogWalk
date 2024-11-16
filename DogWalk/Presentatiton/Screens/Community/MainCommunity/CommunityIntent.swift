//
//  CommunityIntent.swift
//  DogWalk
//
//  Created by 박성민 on 11/12/24.
//

import Foundation
import Combine

protocol CommunityIntentProtocol {
    func onAppear() //뷰 뜰때
    func changeArea(area: CheckPostType)
    func selectCategory(category: CommunityCategoryType)
    func postPageNation()
}

final class CommunityIntent {
    private weak var state: CommunityActionProtocol?
    private var useCase: DefaultCommunityUseCase
    private var cancellables = Set<AnyCancellable>()
    private let network = NetworkManager()
    init(state: CommunityActionProtocol, postType: CheckPostType, categoty: CommunityCategoryType) {
        self.state = state
        self.useCase = DefaultCommunityUseCase(checkPostType: postType, category: categoty)
    }
    
}

extension CommunityIntent: CommunityIntentProtocol {
    func onAppear() { //뷰 로드 시
        state?.changeContentState(state: .loading)
        Task {
            do {
                let result = try await useCase.getPosts(isPaging: false)
                state?.getPosts(result)
                state?.changeContentState(state: .content)
            } catch {
                state?.changeContentState(state: .error)
            }
        }
    }
    func postPageNation() { //포스트 페이지네이션
        state?.changeContentState(state: .loading)
        Task {
            do {
                let result = try await useCase.getPosts(isPaging: true)
                state?.postPageNation(result)
                state?.changeContentState(state: .content)
            } catch {
                state?.changeContentState(state: .error)
            }
        }
    }
    func changeArea(area: CheckPostType) { //위치 vs 전체
        state?.changeContentState(state: .loading)
        Task {
            do {
                let result = try await useCase.changePostType(postType: area, isPaging: false)
                state?.getPosts(result)
                state?.changeContentState(state: .content)
                state?.changeArea(area)
            } catch {
                state?.changeContentState(state: .error)
            }
        }
        
        
    }
    func selectCategory(category: CommunityCategoryType) { //카테고리 변경
        state?.changeContentState(state: .loading)
        Task {
            do {
                let result = try await useCase.changeCategory(category: category, isPaging: false)
                state?.getPosts(result)
                state?.changeContentState(state: .content)
                state?.changeSelectCategory(category)
            } catch {
                state?.changeContentState(state: .error)
            }
        }
    }
    
}
// MARK: - 목업
//private extension CommunityIntent {
//    func fetchPosts() async -> [PostModel]{
//        let mockData = [
//            PostModel(
//                    postID: "1",
//                    created: "2024-11-13",
//                    category: .all,
//                    title: "Used iPhone for Sale",
//                    price: 300,
//                    content: "Selling my iPhone in good condition.",
//                    creator: UserModel(userID: "", nick: "감자", profileImage: ""),
//                    files: ["iphone.jpg"],
//                    likes: ["user2", "user3"],
//                    views: 120,
//                    hashTags: ["#iphone", "#forsale"],
//                    comments: [],
//                    geolocation: GeolocationModel(lat: 37.7749, lon: -122.4194),
//                    distance: 5.0
//                ),
//                PostModel(
//                    postID: "2",
//                    created: "2024-11-12",
//                    category: .free,
//                    title: "Community Cleanup Event",
//                    price: 0,
//                    content: "Join us for a community cleanup event this weekend.",
//                    creator: UserModel(userID: "", nick: "감자", profileImage: ""),
//                    files: ["cleanup.jpg"],
//                    likes: ["user1", "user3", "user4"],
//                    views: 80,
//                    hashTags: ["#community", "#cleanup"],
//                    comments: [],
//                    geolocation: GeolocationModel(lat: 37.7749, lon: -122.4194),
//                    distance: 2.5
//                ),
//                PostModel(
//                    postID: "3",
//                    created: "2024-11-10",
//                    category: .question,
//                    title: "Looking for a Freelance Developer",
//                    price: 0,
//                    content: "Need a developer for a short-term project.",
//                    creator: UserModel(userID: "", nick: "감자", profileImage: ""),
//                    files: ["job.jpg"],
//                    likes: ["user4", "user5"],
//                    views: 150,
//                    hashTags: ["#freelance", "#developer"],
//                    comments: [],
//                    geolocation: GeolocationModel(lat: 34.0522, lon: -118.2437),
//                    distance: 15.0
//                ),
//                
//            ]
//
//        return mockData
//    }
//}
