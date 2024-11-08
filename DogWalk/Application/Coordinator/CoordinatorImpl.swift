//
//  CoordinatorImpl.swift
//  DogWalk
//
//  Created by 김윤우 on 11/8/24.
//

import SwiftUI

final class CoordinatorImpl: DogWalkCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        path.append(sheet)
    }
    
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        path.append(fullScreenCover)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenOver() {
        self.fullScreenCover = nil
    }
    
    // Push
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .tab: CustomTabView() // 탭
        case .login: AuthView() // 로그인
        case .home: HomeView() // 홈
        case .map: MapView() // 산책하기 탭 첫
        case .dogWalkResult: WalkResultView.build() // 산책 결과
        case .communityCreate: CommunityCreateView() // 게시글 작성
        case .community: CommunityView() // 커뮤니티 리스트 화면
        case .communityDetail: CommunityDetailView() // 커뮤니티 게시글 디테일
        case .chatting: ChattingView() // 채팅방 리스트 화면
        case .chattingRoom: ChattingRoomView() // 채팅방
        case .setting: SettingView() // 세팅
        }
    }
    
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        
    }
    
    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCover) -> some View {
        
    }
}
