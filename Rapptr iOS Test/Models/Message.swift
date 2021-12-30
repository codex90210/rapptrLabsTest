//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct messageData: Codable {
    
    var data: [Messages]
}

struct Messages: Codable {
    
    var user_id: String
    var name: String
    var avatar_url: URL?
    var message: String
}

