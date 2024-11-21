//
//  ChatRepository.swift
//  DogWalk
//
//  Created by 김윤우 on 11/21/24.
//

import Foundation
import CoreData

final class ChatRepository {
    static let shared = ChatRepository(context: CoreDataManager.shared.viewContext)  // 싱글턴 인스턴스
    
    private let managedObjectContext: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }

    // 채팅방 생성
    func createChatRoom(chatRoomData: ChattingRoomModel) {
        let chatRoom = CoreChatRoom(context: managedObjectContext)
        chatRoom.roomID = chatRoomData.roomID
        chatRoom.createdAt = chatRoomData.createAt
        chatRoom.meUserID = chatRoomData.me.userID
        chatRoom.meNick = chatRoomData.me.nick
        chatRoom.meProfileImage = chatRoomData.me.profileImage
        chatRoom.ohterUserID = chatRoomData.otherUser.userID
        chatRoom.otherNick = chatRoomData.otherUser.nick
        chatRoom.otherProfileImage = chatRoomData.otherUser.profileImage
        chatRoom.lastChat?.chatID = chatRoomData.lastChat?.chatID
        chatRoom.lastChat?.lastChat = chatRoomData.lastChat?.lastChat
        chatRoom.lastChat?.type = chatRoomData.lastChat?.type.rawValue
        chatRoom.lastChat?.sender?.nick = chatRoomData.lastChat?.sender.nick
        chatRoom.lastChat?.sender?.userID = chatRoomData.lastChat?.sender.userID
        chatRoom.lastChat?.sender?.profileImage = chatRoomData.lastChat?.sender.profileImage
        chatRoom.updateAt = chatRoomData.updatedAt
        chatRoom.messages = []

        saveContext()
    }

    // 메시지 생성
    func createChatMessage(chatID: String, content: String, sender: UserModel, files: [String], in chatRoom: CoreChatRoom) -> CoreChatMessage {
        let newMessage = CoreChatMessage()
        newMessage.chatID = chatID
        newMessage.roomID = chatRoom.roomID
        newMessage.type = "text" // 필요 시 수정 가능
        newMessage.message = content
        newMessage.senderUserID = sender.userID
        newMessage.senderUserNick = sender.nick
        newMessage.senderProfileImage = sender.profileImage
        newMessage.files = files
        return newMessage
    }

    // 채팅방 업데이트
    func updateChatRoom(chatRoomID: String, newMessages: [CoreChatMessage]) {
        let request: NSFetchRequest<CoreChatRoom> = CoreChatRoom.fetchRequest()
        request.predicate = NSPredicate(format: "roomID == %@", chatRoomID)

        do {
            if let chatRoom = try managedObjectContext.fetch(request).first {
                var messages = chatRoom.messages ?? []
                messages.append(contentsOf: newMessages)
                chatRoom.messages = messages

                saveContext()
                print("Chat room updated successfully.")
            } else {
                print("Chat room not found for ID: \(chatRoomID)")
            }
        } catch {
            print("Error updating chat room: \(error.localizedDescription)")
        }
    }

    //전체 채팅방 가져오기
    func fetchAllChatRoom() -> [ChattingRoomModel]? {
        let request: NSFetchRequest<CoreChatRoom> = CoreChatRoom.fetchRequest()
        do {
            let coreChatRooms = try managedObjectContext.fetch(request)
            return coreChatRooms.map { chatRoom in
                return ChattingRoomModel(roomID: chatRoom.roomID ?? "룸아이디 없음",
                                         createAt: chatRoom.createdAt ?? "",
                                         updatedAt: "" ,
                                         me: UserModel(userID: chatRoom.meUserID ?? "내 아디 없음" , 
                                                       nick: chatRoom.meNick ?? "내 닉 없음",
                                                       profileImage: chatRoom.meProfileImage ?? "내이미지없음"),
                                         otherUser: UserModel(userID: chatRoom.ohterUserID ?? "내 아디 없음", nick: chatRoom.otherNick ?? "내 닉 없음", profileImage: chatRoom.otherProfileImage ?? "내이미지없음"),
                                         lastChat: nil )
            }
        } catch {
            return nil
        }
    }
    
    
    // 채팅방 RoomID로 가져오기
    func fetchChatRoom(chatRoomID: String) -> CoreChatRoom? {
        let request: NSFetchRequest<CoreChatRoom> = CoreChatRoom.fetchRequest()
        request.predicate = NSPredicate(format: "roomID == %@", chatRoomID)

        do {
            return try managedObjectContext.fetch(request).first
        } catch {
            print("Error fetching chat room: \(error.localizedDescription)")
            return nil
        }
    }
    
    

    // 모든 메시지 가져오기
    func fetchAllMessages(for chatRoomID: String) -> [ChattingModel] {
        let request: NSFetchRequest<CoreChatRoom> = CoreChatRoom.fetchRequest()
        request.predicate = NSPredicate(format: "roomID == %@", chatRoomID)

        do {
            if let chatRoom = try managedObjectContext.fetch(request).first {
                let coreMessages = chatRoom.messages ?? []
                return coreMessages.map(convertToChattingModel)
            } else {
                print("Chat room not found for ID: \(chatRoomID)")
                return []
            }
        } catch {
            print("Error fetching messages: \(error.localizedDescription)")
            return []
        }
    }

    func createSpecificChatRoom(rooID: String) {
        // 특정 roomID로 채팅방 생성
        let chatRoomData = ChattingRoomModel(
            roomID: rooID, // 특정 roomID 사용
            createAt: "",  // 생성 일자
            updatedAt: "", // 업데이트 일자
            me: UserModel(userID: "", nick: "", profileImage: ""), // 사용자 정보
            otherUser: UserModel(userID: "", nick: "", profileImage: ""), // 다른 사용자 정보
            lastChat: nil // 마지막 채팅 (없다면 nil)
        )
        
        createChatRoom(chatRoomData: chatRoomData) // 채팅방 생성
        print("Specific chat room created with ID: \(chatRoomData.roomID)")
    }

    // 메시지 변환
    private func convertToChattingModel(_ coreMessage: CoreChatMessage) -> ChattingModel {
        return ChattingModel(
            chatID: coreMessage.chatID ?? "",
            roomID: coreMessage.roomID ?? "",
            type: MessageType(rawValue: coreMessage.type ?? "text") ?? .text,
            content: coreMessage.message ?? "",
            sender: UserModel(
                userID: coreMessage.senderUserID ?? "",
                nick: coreMessage.senderUserNick ?? "",
                profileImage: coreMessage.senderProfileImage ?? ""
            ),
            files: coreMessage.files ?? []
        )
    }

    // 컨텍스트 저장
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
