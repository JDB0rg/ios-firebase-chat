//
//  Model.swift
//  Firebase Chat
//
//  Created by Madison Waters on 2/12/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

import Foundation

class ChatRoom: Decodable, Equatable {
    
    let name: String
    let messages: [ChatRoom.Message]
    let roomID: String
    
    init(name: String, messages: [Message] = [], roomID: String = UUID().uuidString) {
        self.name = name
        self.messages = messages
        self.roomID = roomID
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case messages
        case roomID
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        roomID = try container.decode(String.self, forKey: .roomID)
        
        let messagesDictionary = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        messages = messagesDictionary?.compactMap({ $0.value }) ?? []
        
    }
    
    struct Message: Codable, Equatable {
        
        let user: String
        let text: String?
        let identifier: String
        //let timestamp: Date
        
        init(user: String, text: String, identifier: String = UUID().uuidString) {
            self.user = user
            self.text = text
            self.identifier = identifier
        }
    }
    
    static func ==(lhs: ChatRoom, rhs: ChatRoom) -> Bool {
        return lhs.name == rhs.name &&
            lhs.messages == rhs.messages &&
            lhs.roomID == rhs.roomID
    }
}
