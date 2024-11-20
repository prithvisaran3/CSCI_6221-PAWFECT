//
//  ChatContoller.swift
//  pawfect_ASP
//
//  Created by Chandan Kumar r on 11/19/24.
//

import Foundation
import SwiftUI
import Supabase
@MainActor
class ChatController: ObservableObject {
    // Properties to hold the user data
    @Published var ids = [String]()
    @Published var created_ats = [String]()
    @Published var user_ids_1 = [String]()
    @Published var user_1_responses = [Bool]()
    @Published var user_ids_2 = [String]()
    @Published var user_2_responses = [Bool]()
    @Published var chat_histories = [[ChatEntry]]()
    
    @Published var name = [String]()
    @Published var img = [String]()
    func fetchChatData() async {
        do {
            let responses: [ChatHistory] = try await supabase
                .from("chat_history")
                .select()
                .eq("user_id_1", value: "2739ef29-a1f5-4427-890e-e7a6d128fdcc")
                .eq("user_id_2", value: "2739ef29-a1f5-4427-890e-e7a6d128fdcc")
                .eq("user_2_response", value: true)
                .execute()
                .value

            // Clear existing data
            ids.removeAll()
            created_ats.removeAll()
            user_ids_1.removeAll()
            user_1_responses.removeAll()
            user_ids_2.removeAll()
            user_2_responses.removeAll()
            chat_histories.removeAll()

            // Iterate over each response and update the properties
            for record in responses {
                ids.append(record.id ?? "")
                created_ats.append(record.createdAt ?? "")
                user_ids_1.append(record.userId1 ?? "")
                user_1_responses.append(record.userId1response ?? false)
                user_ids_2.append(record.userId2 ?? "")
                user_2_responses.append(record.userId2response ?? false)
                chat_histories.append(record.chathistory ?? [])
                
                // Debug print statements
                //                debugPrint("id: \(record.id ?? "")")
                //                debugPrint("created at: \(record.createdAt ?? "")")
                //                debugPrint("User ID 1: \(record.userId1 ?? "") - Response: \(record.userId1response ?? false)")
                //debugPrint("User ID 2: \(record.userId2 ?? "") - Response: \(record.userId2response ?? false)")
                //                debugPrint("Chat history count: \(record.chathistory?.count ?? 0)")
                //                for entry in record.chathistory ?? [] {
                //                    debugPrint("Chat Entry - User 1: \(entry.user_1 ?? ""), User 2: \(entry.user_2 ?? "")")
                //                }
                
                
                
            }
            
        } catch {
            debugPrint("Error fetching user data: \(error)")
        }
    }
    
    
}

struct ChatHistory: Decodable, Encodable {
    let id: String?
    let createdAt: String?
    let userId1: String?
    let userId1response: Bool?
    let userId2: String?
    let userId2response: Bool?
    var chathistory: [ChatEntry]?
    
    var name : String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case userId1 = "user_id_1"
        case userId1response = "user_1_response"
        case userId2 = "user_id_2"
        case userId2response = "user_2_response"
        case chathistory = "chat_history"
        case name = "name"
    }
}

struct ChatEntry: Decodable, Encodable {
    var user_1: String?
    var user_2: String?
}
