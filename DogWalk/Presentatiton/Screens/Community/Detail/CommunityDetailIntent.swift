//
//  CommunityDetailIntent.swift
//  DogWalk
//
//  Created by 박성민 on 11/19/24.
//

import Foundation

protocol CommunityDetailIntentProtocol {
}

final class CommunityDetailIntent {
    private weak var state: CommunityDetailActionProtocol?
    private var useCase: CommunityUseCase
    init(state: CommunityDetailActionProtocol, useCase: CommunityUseCase) {
        self.state = state
        self.useCase = useCase
    }
}

extension CommunityDetailIntent: CommunityDetailIntentProtocol {
}
