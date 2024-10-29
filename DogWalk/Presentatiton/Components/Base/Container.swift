//
//  Container.swift
//  DogWalk
//
//  Created by junehee on 10/29/24.
//

import SwiftUI
import Combine

final class Container<Intent, Model>: ObservableObject {
    let intent: Intent // Input
    let model: Model // Output
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model
        
        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}

