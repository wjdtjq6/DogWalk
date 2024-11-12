//
//  ChatMessage+CoreDataProperties.swift
//  DogWalk
//
//  Created by 김윤우 on 11/11/24.
//
//

import Foundation
import CoreData


extension ChatMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessage> {
        return NSFetchRequest<ChatMessage>(entityName: "ChatMessage")
    }

    @NSManaged public var roomID: String?
    @NSManaged public var chatID: String?
    @NSManaged public var content: String?
    @NSManaged public var senderProfileImage: String?
    @NSManaged public var senderUserID: String?
    @NSManaged public var senderNick: String?
    @NSManaged public var files: [String]?
    @NSManaged public var room: ChatRoom?

}

extension ChatMessage : Identifiable {

}
