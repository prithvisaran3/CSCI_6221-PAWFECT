//
//  Profile.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 11/15/24.
//

import Foundation

struct Profile : Decodable, Encodable{
    let username: String?
    let fullName: String?
    let website: String?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case fullName="full_name"
        case website
        case avatarURL = "avatar_url"
    }
}
