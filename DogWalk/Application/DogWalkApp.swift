//
//  DogWalkApp.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import SwiftUI

@main
struct DogWalkApp: App {
    @StateObject var appCoordinator: MainCoordinator = MainCoordinator()
    private var isUser = UserManager.shared.isUser
    
    init() {
        let appearance = UINavigationBarAppearance()
        // 뒤로 가기 버튼의 텍스트 제거
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.left"), transitionMaskImage: UIImage(systemName: "chevron.left"))
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0) // 텍스트 위치를 화면 밖으로 밀어내기
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        // 전체 내비게이션 바 스타일 설정
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            if isUser {
                ContentView()
                    .environmentObject(appCoordinator)
            } else {
                LoginView.build()
                    .environmentObject(appCoordinator)
            }
        }
    }
}
