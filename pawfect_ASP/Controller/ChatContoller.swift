//
//  ChatContoller.swift
//  pawfect_ASP
//
//  Created by Chandan Kumar r on 11/19/24.
//

import Foundation

import SwiftUI
import Supabase
import PhotosUI

@MainActor
@Observable

class ChatController {
    var id = ""
    var created_at = ""
    var user_id_1 = ""
    var user_1_response = false
    var user_id_2 = ""
    var user_2_response = false
    var chat_history = ""
    
    func getChatHistory() async {
        do {
            
            let response:Chat_History = try await supabase
                .from("chat_history")
                .select() // Specify the columns to fetch, or use "*" for all
                .eq( "user_id_1", value: "5312ed07-c7fc-423b-bb4d-928904e8a725")
                .single() // If you expect only one result
                .execute()
                .value
            
            id = response.id ?? ""
            user_1_response = response.userId1response ?? false
            user_id_1 = response.userId1 ?? ""
            user_id_2 = response.userId2 ?? ""
            user_2_response = response.userId2response ?? false
            chat_history = response.chathistory ?? ""
            debugPrint("id: \(id)")
            debugPrint("user_1_response: \(user_1_response)")
            debugPrint("user_2_response: \(user_2_response)")
            debugPrint("user_id_1:\(user_id_1)")
            debugPrint("user_id_2:\(user_id_2)")
            debugPrint("chat historye:\(chat_history)")
            
            
        } catch let error {
            debugPrint("Error fetching profile: \(error)")
        }
    }
}

struct Chat_History : Decodable, Encodable{
    let id: String?
    let createdAt: String?
    let userId1: String?
    let userId1response: Bool?
    let userId2: String?
    let userId2response: Bool?
    let chathistory: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt = "created_at"
        case userId1 = "user_id_1"
        case userId1response = "user_1_response"
        case userId2 = "user_id_2"
        case userId2response = "user_2_response"
        case chathistory = "chat_history"
    }
}
