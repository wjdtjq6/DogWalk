//
//  CommunityIntent.swift
//  DogWalk
//
//  Created by 박성민 on 11/12/24.
//

import Foundation

protocol CommunityIntentProtocol {
    func onAppear() //뷰 뜰때
    func changeArea(area: AreaType)
    func selectCategory(category: CommunityCategoryType)
}

final class CommunityIntent {
    private weak var state: CommunityActionProtocol?
    private let network = NetworkManager()
    
    init(state: CommunityActionProtocol) {
        self.state = state
    }
    
}
enum AreaType: String {
    case userArea = "우리 동네"
    case allArea = "모든 동네"
}

extension CommunityIntent: CommunityIntentProtocol {

    func onAppear() {
        
    }
    func changeArea(area: AreaType) {
        print(area)
    }
    func selectCategory(category: CommunityCategoryType) {
        print("dd")
    }
}

private extension CommunityIntent {
    
}
