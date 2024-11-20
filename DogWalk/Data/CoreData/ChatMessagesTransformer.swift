//
//  ChatMessagesTransformer.swift
//  DogWalk
//
//  Created by 김윤우 on 11/20/24.
//

import Foundation

class ChatMessagesTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] {
        [ChatMessage.self]
    }

    static func register() {
        let className = String(describing: ChatMessagesTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = ChatMessagesTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
