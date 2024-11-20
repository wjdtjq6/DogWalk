//
//  ChatRepository.swift
//  DogWalk
//
//  Created by 김윤우 on 11/12/24.
//

import CoreData

final class ChatRepository {
    private let managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    
    // MARK: 채팅방 관련 메서드
    
    // 채팅방 생성
    @discardableResult
    func createChatRoom(chatRoomData: ChattingRoomModel) -> ChatRoom {
        let chatRoom = ChatRoom(context: managedObjectContext)
        chatRoom.chatRoomID = chatRoomData.roomID                           // 채팅방 아이디
        chatRoom.meID = chatRoomData.me.userID                              // 내 userID
        chatRoom.meNick = chatRoomData.me.nick                              // 내 닉네임
        chatRoom.meProfileImage = chatRoomData.me.profileImage              // 내 프로필 이미지
        chatRoom.otherUserId = chatRoomData.otherUser.userID                // 상대방 userID
        chatRoom.otherUserNick = chatRoomData.otherUser.nick                // 상대방 닉네임
        chatRoom.otherUserProfieImage = chatRoomData.otherUser.profileImage // 상대방 프로필 이미지
        chatRoom.updatedAt = chatRoomData.updatedAt                         // 마지막 채팅 날짜
        chatRoom.createAt = chatRoomData.createAt                           // 채팅 시작 날짜
        
        saveContext()
        return chatRoom
    }
    
    // 특정 ID로 채팅방 정보 가져오기
    func fetchChatRoom(chatRoomID: String) -> ChatRoom? {
        let request: NSFetchRequest<ChatRoom> = ChatRoom.fetchRequest()
        request.predicate = NSPredicate(format: "chatRoomID == %@", chatRoomID)
        
        do {
            return try managedObjectContext.fetch(request).first
        } catch {
            print("특정 채팅방 가져오기 오류")
            return nil
        }
    }
    
    // 모든 채팅방 가져오기
    func fetchAllChatRooms() -> [ChatRoom] {
        let request: NSFetchRequest<ChatRoom> = ChatRoom.fetchRequest()
        
        do {
            return try managedObjectContext.fetch(request)
        } catch {
            print("모든 채팅방 가져오기 오류")
            return []
        }
    }
    
    // 특정 채팅방 삭제
    func deleteChatRoom(roomID: String) {
        let request: NSFetchRequest<ChatRoom> = ChatRoom.fetchRequest()
        request.predicate = NSPredicate(format: "chatRoomID == %@", roomID)
        
        do {
            let chatRooms = try managedObjectContext.fetch(request)
            if let chatRoomToDelete = chatRooms.first {
                managedObjectContext.delete(chatRoomToDelete)
                saveContext()
                print("채팅방 삭제")
            } else {
                print("삭제할 채팅방을 찾을 수 없음")
            }
        } catch {
            print("채팅방 삭제 중 오류 발생")
        }
    }
    
    // 마지막 채팅 업데이트
    func updateLastChat(chatRoomData: ChattingRoomModel) {
        if let chatRoom = fetchChatRoom(chatRoomID: chatRoomData.roomID) {
            chatRoom.lastChatID = chatRoomData.lastChat?.chatID              // 채팅방 ID
            chatRoom.lastChatType = chatRoomData.lastChat?.type.rawValue     // 마지막 채팅이 글자인지 사진인지
            chatRoom.lastChatContent = chatRoomData.lastChat?.lastChat       // 마지막 채팅
            chatRoom.updatedAt = chatRoomData.updatedAt                     // 최근 채팅시간
            
            saveContext()
        }
    }
    
    // MARK: 채팅 메시지 관련 메서드
    
    // 채팅 추가
    func createChatMessage(chatID: String, content: String, sender: UserModel, files: [String]? = nil, in chatRoom: ChatRoom) -> ChatMessage {
        let chatMessage = ChatMessage(context: managedObjectContext)
        chatMessage.chatID = chatID                             // 채팅 아이디
        chatMessage.content = content                           // 채팅 내용
        chatMessage.senderUserID = sender.userID                // 보낸 사람 ID
        chatMessage.senderNick = sender.nick// 보낸 사람 닉네임
        chatMessage.senderProfileImage = sender.profileImage    // 보낸 사람 프로필 이미지
        chatMessage.files = files                               // 사진 파일
        chatMessage.room = chatRoom                             // 속해있는 채팅룸
        
        saveContext()
        return chatMessage
    }
    
    // 해당 채팅방 메세지 전체 가져오기
    func fetchMessages(in chatRoom: ChatRoom) -> [ChatMessage] {
        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        request.predicate = NSPredicate(format: "room == %@", chatRoom)
        
        do {
            return try managedObjectContext.fetch(request)
        } catch {
            print("채팅방 메세지 가져오기 오류")
            return []
        }
    }
    
    // ChatID로 해당 메세지 삭제
    func deleteMessage(chatID: String) {
        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        request.predicate = NSPredicate(format: "chatID == %@", chatID)
        
        do {
            let messages = try managedObjectContext.fetch(request)
            if let messageToDelete = messages.first {
                managedObjectContext.delete(messageToDelete)
                saveContext()
                print("메시지 삭제 성공")
            } else {
                print("삭제할 메시지를 찾을 수 없음")
            }
        } catch {
            print("메시지 삭제 중 오류")
        }
    }
    
    // 특정 채팅방 전체 메시지 삭제
    func deleteAllMessages(chatRoomID: String) {
        guard let chatRoom = fetchChatRoom(chatRoomID: chatRoomID) else {
            print("삭제할 채팅방 찾을 수 없음")
            return
        }
        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        request.predicate = NSPredicate(format: "room == %@", chatRoom)
        
        do {
            let messages = try managedObjectContext.fetch(request)
            for message in messages {
                managedObjectContext.delete(message)
            }
            saveContext()
            print("채팅방 ID \(chatRoomID)의 모든 메시지가 삭제")
        } catch {
            print("채팅방 ID \(chatRoomID)의 모든 메시지 삭제 실패")
        }
    }
    
    // 해당 채팅방과 모든 메시지 가져오기
    func fetchChatRoomAndMessages(chatRoomID: String) -> (ChatRoom?, [ChatMessage]) {
        guard let chatRoom = fetchChatRoom(chatRoomID: chatRoomID) else {
            print("해당 채팅방을 찾을 수 없음")
            return (nil, [])
        }
        let messages = fetchMessages(in: chatRoom)
        return (chatRoom, messages)
    }
    
    private func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("CoreData 저장 실패")
            }
        }
    }
}

extension ChatRepository {
    
    //채팅방 메세지 업데이트 함수 
    func updateChatRoom(chatRoomID: String, newMessages: [ChatMessages], context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<ChatRoom> = ChatRoom.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "chatRoomID == %@", chatRoomID)
        fetchRequest.fetchLimit = 1

        do {
            // 검색된 ChatRoom 가져오기
            if let chatRoom = try context.fetch(fetchRequest).first {
                // 기존 메시지에 새로운 메시지 추가 또는 대체
                chatRoom.chatMessages = newMessages
                
                // 데이터 저장
                try context.save()
                print("ChatRoom \(chatRoomID) updated successfully!")
            } else {
                print("No ChatRoom found with ID \(chatRoomID)")
            }
        } catch {
            print("Failed to update ChatRoom \(chatRoomID): \(error)")
        }
    }
}
