//
//  ChatRoom+CoreDataProperties.swift
//  DogWalk
//
//  Created by 김윤우 on 11/11/24.
//
//

import CoreData


extension ChatRoom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatRoom> {
        return NSFetchRequest<ChatRoom>(entityName: "ChatRoom")
    }

    @NSManaged public var meProfileImage: String?
    @NSManaged public var meNick: String?
    @NSManaged public var meID: String?
    @NSManaged public var updatedAt: String?
    @NSManaged public var createAt: String?
    @NSManaged public var chatRoomID: String?
    @NSManaged public var otherUserProfieImage: String?
    @NSManaged public var otherUserNick: String?
    @NSManaged public var otherUserId: String?
    @NSManaged public var lastChatContent: String?
    @NSManaged public var lastChatID: String?
    @NSManaged public var lastChatType: String?
    @NSManaged public var messages: NSSet?

}

// MARK: Generated accessors for messages
extension ChatRoom {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: ChatMessage)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: ChatMessage)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}

extension ChatRoom : Identifiable {

}
