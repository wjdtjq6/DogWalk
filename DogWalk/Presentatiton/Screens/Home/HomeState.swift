//
//  HomeState.swift
//  DogWalk
//
//  Created by 김윤우 on 11/12/24.

import Foundation
import Combine


protocol HomeStateProtocol {
    var contentState: HomeContentState { get }
    var popularityDogWalkList: [PostModel] { get }  // 인기산책 인증 데이터
    var profileButtonState: Bool { get set }
    var weatherData: WeatherData { get }
}

protocol HomeIntentActionProtocol: AnyObject {
    func getPostList(_ posts: [PostModel])
    func changeContentState(state: HomeContentState)
    func updatePostList(posts: [PostModel])
    func updateProfileButtonSate(_ isButtonTapState: Bool)
    func getWeatherData(weatherData: WeatherData)
}

@Observable
final class HomeState: HomeStateProtocol, ObservableObject {
    var contentState: HomeContentState = .loading
    var popularityDogWalkList: [PostModel] = []
    var profileButtonState: Bool = false
    var weatherData: WeatherData = WeatherData(weather: "", userAddress: "")

}

extension HomeState: HomeIntentActionProtocol {
    func getWeatherData(weatherData: WeatherData)  {
        self.weatherData = weatherData
    }
    
    
    func updatePostList(posts: [PostModel]) {
        popularityDogWalkList = posts
    }
    
    // 인기 게시글 가져오기
    func getPostList(_ posts: [PostModel]) {
        self.popularityDogWalkList = posts
    }
    
    // 앱 상태 변경하기
    func changeContentState(state: HomeContentState) {
        self.contentState =  state
    }
    
    func getPostList() async {
        print("게시물 가지고오기")
        do {
            let query = GetPostQuery(next: "", limit: "15", category: ["산책인증"])
            let future = try await network.request(target: .post(.getPosts(query: query)), of: PostResponseDTO.self)
            future
                .sink { result in
                    switch result {
                    case .finished:
                        print("🗒️게시물 통신 성공")
                    case .failure(let error):
                        print("🚨게시물 통신 실패", error)
                    }
                } receiveValue: { [weak self] data in
                    guard let self else { return }
                    let domain = data.toDomain()
                    self.updatePopularityList(with: domain.data)
                    isHomeViewFirstInit = false
                }
                .store(in: &cancellables)
        } catch {
            print("HomeState getPostList메서드 오류")
        }
    //세팅 뷰 화면 전환 플래그 상태 변경하기
    func updateProfileButtonSate(_ isButtonTapState: Bool) {
        profileButtonState = isButtonTapState
    }
    
    // 조회수 기준 내림차순 정렬
    private func updatePopularityList(with posts: [PostModel]) {
        self.popularityDogWalkList = posts.sorted(by: { $0.views > $1.views })
    }
}
