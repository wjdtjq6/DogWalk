//
//  CoreChatMessageTransformer.swift
//  DogWalk
//
//  Created by 김윤우 on 11/21/24.
//

import Foundation

class CoreChatMessageTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let messages = value as? [CoreChatMessage] else { return nil }
        
        // CoreData의 지정되어 있지 않은 Custom(Transformable은 NsData형식으로 CoreData에 저장 후 사용할 때 Decoding)
        // CoreChatMessage 배열을 NSData로 변환 (PropertyListEncoder 사용)
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(messages)
            return data
        } catch {
            print("CoreChatMessageTransformer 인코딩 실패: \(error)")
            return nil
        }
    }
    
    // NsData를 CoreChatMessage 배열로 복원
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let decoder = PropertyListDecoder()
            let messages = try decoder.decode([CoreChatMessage].self, from: data)
            return messages
        } catch {
            print("CoreChatMessageTransformer 디코딩 실패: \(error)")
        }
        return nil
    }
    
    // 변환기
    static func register() {
        let className = String(describing: CoreChatMessageTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = CoreChatMessageTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
