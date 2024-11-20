//
//  ChatMessages.swift
//  DogWalk
//
//  Created by 김윤우 on 11/20/24.
//

import Foundation

class ChatMessages {
    static var supportsSecureCoding = true
    
    var chatID: String?
    var roomID: String?
    var type: String?
    var files: [String]?
    var message: String?
    var senderUserID: String?
    var senderUserNick: String?
    var profileImage: String?
    
    
    init(chatID: String? = nil, roomID: String? = nil, type: String? = nil, files: [String]? = nil, message: String? = nil, senderUserID: String? = nil, senderUseNick: String? = nil, profileImage: String? = nil) {
        self.chatID = chatID
        self.roomID = roomID
        self.type = type
        self.files = files
        self.message = message
        self.senderUserID = senderUserID
        self.senderUserNick = senderUseNick
        self.profileImage = profileImage
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(chatID, forKey: Key.chatID.rawValue)
        coder.encode(roomID, forKey: Key.roomID.rawValue)
        coder.encode(type, forKey: Key.type.rawValue)
        coder.encode(files, forKey: Key.files.rawValue)
        coder.encode(message, forKey: Key.message.rawValue)
        coder.encode(senderUserID, forKey: Key.senderUserID.rawValue)
        coder.encode(senderUserNick, forKey: Key.senderUserNick.rawValue)
        coder.encode(profileImage, forKey: Key.profileImage.rawValue)
        }

    required convenience init?(coder: NSCoder) {
            guard let chatID = coder.decodeObject(forKey: Key.chatID.rawValue) as? String,
                  let roomID = coder.decodeObject(forKey: Key.roomID.rawValue) as? String,
                  let type = coder.decodeObject(forKey: Key.type.rawValue) as? String,
                  let files = coder.decodeObject(forKey: Key.files.rawValue) as? [String],
                  let message = coder.decodeObject(forKey: Key.message.rawValue) as? String,
                  let senderUserID = coder.decodeObject(forKey: Key.senderUserID.rawValue) as? String,
                  let senderUserNick = coder.decodeObject(forKey: Key.senderUserNick.rawValue) as? String,
                  let profileImage = coder.decodeObject(forKey: Key.profileImage.rawValue) as? String else {
                return nil
            }
            
        self.init(chatID: chatID, roomID: roomID, type: type, files: files, message: message, senderUserID: senderUserID, senderUseNick: senderUserNick, profileImage: profileImage)
        }
}

enum Key: String {
    case chatID = "chatID"
    case roomID = "roomID"
    case type = "type"
    case files = "files"
    case message = "message"
    case senderUserID = "senderUserID"
    case senderUserNick = "senderUserNick"
    case profileImage = "profileImage"
}
