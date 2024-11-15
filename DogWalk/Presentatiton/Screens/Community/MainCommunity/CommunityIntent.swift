//
//  CommunityIntent.swift
//  DogWalk
//
//  Created by 박성민 on 11/12/24.
//

import Foundation
import Combine
enum AreaType: String {
    case userArea = "우리 동네"
    case allArea = "모든 동네"
}
protocol CommunityIntentProtocol {
    func onAppear() //뷰 뜰때
    func changeArea(area: AreaType)
    func selectCategory(category: CommunityCategoryType)
}

final class CommunityIntent {
    private weak var state: CommunityActionProtocol?
    private let network = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(state: CommunityActionProtocol) {
        self.state = state
    }
    
}

extension CommunityIntent: CommunityIntentProtocol {

    func onAppear() {
        print("appear")
        
        Task {
            await writePost()
//            let result = await fetchPosts()
//            state?.getPosts(result)
        }
    }
    func changeArea(area: AreaType) {
        var areaStr = ""
        switch area {
        case .userArea:
            areaStr = UserManager.shared.roadAddress
        case .allArea:
            areaStr = "전국"
        }
        state?.changeArea(areaStr)
    }
    func selectCategory(category: CommunityCategoryType) {
        state?.changeSelectCategory(category)
    } //카테고리 변경
    
}
// MARK: - 목업
private extension CommunityIntent {
    func fetchPosts() async -> [PostModel]{
        let mockData = [
            PostModel(
                    postID: "1",
                    created: "2024-11-13",
                    category: .all,
                    title: "Used iPhone for Sale",
                    price: 300,
                    content: "Selling my iPhone in good condition.",
                    creator: UserModel(userID: "", nick: "감자", profileImage: ""),
                    files: ["iphone.jpg"],
                    likes: ["user2", "user3"],
                    views: 120,
                    hashTags: ["#iphone", "#forsale"],
                    comments: [],
                    geolocation: GeolocationModel(lat: 37.7749, lon: -122.4194),
                    distance: 5.0
                ),
                PostModel(
                    postID: "2",
                    created: "2024-11-12",
                    category: .free,
                    title: "Community Cleanup Event",
                    price: 0,
                    content: "Join us for a community cleanup event this weekend.",
                    creator: UserModel(userID: "", nick: "감자", profileImage: ""),
                    files: ["cleanup.jpg"],
                    likes: ["user1", "user3", "user4"],
                    views: 80,
                    hashTags: ["#community", "#cleanup"],
                    comments: [],
                    geolocation: GeolocationModel(lat: 37.7749, lon: -122.4194),
                    distance: 2.5
                ),
                PostModel(
                    postID: "3",
                    created: "2024-11-10",
                    category: .question,
                    title: "Looking for a Freelance Developer",
                    price: 0,
                    content: "Need a developer for a short-term project.",
                    creator: UserModel(userID: "", nick: "감자", profileImage: ""),
                    files: ["job.jpg"],
                    likes: ["user4", "user5"],
                    views: 150,
                    hashTags: ["#freelance", "#developer"],
                    comments: [],
                    geolocation: GeolocationModel(lat: 34.0522, lon: -118.2437),
                    distance: 15.0
                ),
                
            ]

        return mockData
    }
}
private extension CommunityIntent {
//    func fetchPosts() async {
//        do {
//            let result = try await network.fetchPosts(category: nil, isPaging: false)
//            result.sink { err in
//                print(err)
//            } receiveValue: { data in
//                print(data)
//            }
//            .store(in: &cancellables)
//
//        } catch {
//            
//        }
//    }
    func writePost() async {
        print("게시글 작성 시작")
        do {
            let body = PostBody(category: "궁금해요", title: "테스트", price: 10, content: "테스트입니당.~", files: [""], longitude: 37.555499, latitude: 126.970611)
            let result = try await network.writePost(body: body)
            result.sink { err in
                print(err)
            } receiveValue: { data in
                print(data)
            }
            .store(in: &cancellables)

        } catch {
            
        }
    }
}
