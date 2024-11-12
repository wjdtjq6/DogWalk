//
//  Chattingㅌ.swift
//  DogWalk
//
//  Created by 김윤우 on 11/11/24.
//

import SwiftUI
import CoreData

struct TestView: View {
    @State private var chatRooms: [ChatRoom] = []
    @State private var messages: [ChatMessage] = []
    @State private var selectedChatRoom: ChatRoom?
    
    private let chatRepo: ChatRepository
    
    init(context: NSManagedObjectContext) {
        self.chatRepo = ChatRepository(context: context)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Chat Rooms")) {
                        ForEach(chatRooms, id: \.self) { chatRoom in
                            Button(action: {
                                loadMessages(in: chatRoom)
                            }) {
                                Text(chatRoom.chatRoomID ?? "Unknown Room")
                            }
                        }
                    }
                    
                    if let selectedChatRoom = selectedChatRoom {
                        Section(header: Text("Messages in \(selectedChatRoom.chatRoomID ?? "Room")")) {
                            ForEach(messages, id: \.self) { message in
                                Text(message.content ?? "No content")
                            }
                        }
                    }
                }
                
                HStack {
                    Button("Load Chat Rooms") {
                        loadChatRooms()
                    }
                    .padding()
                    
                    Button("Add Test Data") {
                        addTestData()
                    }
                    .padding()
                }
                
                HStack {
                    Button("Delete First Chat Room") {
                        if let firstRoom = chatRooms.first {
                            deleteChatRoom(roomID: firstRoom.chatRoomID ?? "")
                            loadChatRooms()
                        }
                    }
                    .padding()
                    
                    Button("Delete First Message in Selected Room") {
                        if let firstMessage = messages.first {
                            deleteMessage(message: firstMessage)
                            loadMessages(in: selectedChatRoom!)
                        }
                    }
                    .padding()
                    
                    Button("Delete All Messages in Selected Room") {
                        if let selectedChatRoom = selectedChatRoom {
                            deleteAllMessages(in: selectedChatRoom.chatRoomID ?? "")
                            loadMessages(in: selectedChatRoom)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Test View")
        }
    }
    
    private func loadChatRooms() {
        chatRooms = chatRepo.fetchAllChatRooms()
    }
    
    private func loadMessages(in chatRoom: ChatRoom) {
        selectedChatRoom = chatRoom
        messages = chatRepo.fetchMessages(in: chatRoom)
    }
    
    private func addTestData() {
        let user1 = UserModel(userID: "1", nick: "User1", profileImage: "profile1.jpg")
        let user2 = UserModel(userID: "2", nick: "User2", profileImage: "profile2.jpg")
        
        let chatRoom = chatRepo.createChatRoom(
            chatRoomData: ChatRoomModel(
                roomID: "room\(Int.random(in: 1...10))",
                createAt: "12",
                updatedAt: "1123",
                me: UserModel(userID: "test1", nick: "test1", profileImage: "test1"),
                otherUser: UserModel(userID: "test2", nick: "test2", profileImage: "test2"),
                lastChat: LastChatModel(type: .text, chatID: "last1", lastChat: "Hello!", sender: UserModel(userID: "test3", nick: "test2", profileImage: "test2"))
            )
        )
        
        let message1 = chatRepo.createChatMessage(chatID: "msg001", content: "Hello, User2!", sender: user1, in: chatRoom)
        let message2 = chatRepo.createChatMessage(chatID: "msg002", content: "Hi, User1!", sender: user2, in: chatRoom)
        
        print("Test data added: \(message1.content ?? "") and \(message2.content ?? "")")
        
        loadChatRooms()
    }
    
    private func deleteChatRoom(roomID: String) {
        chatRepo.deleteChatRoom(roomID: roomID)
    }
    
    private func deleteMessage(message: ChatMessage) {
        chatRepo.deleteMessage(chatID: message.chatID ?? "")
        print("Message deleted: \(message.content ?? "No Content")")
    }
    
    private func deleteAllMessages(in roomID: String) {
        chatRepo.deleteAllMessages(chatRoomID: roomID)
    }
}
