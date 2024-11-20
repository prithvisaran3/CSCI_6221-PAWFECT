//
//  Profile.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 11/15/24.
//

import Foundation

struct Profile : Decodable, Encodable{
    let dogName: String?
    let dogBreed: String?
    let dogAge: String?
    let dogGender: String?
    let ownerName: String?
    let phoneNumber: String?
    let avatarURL: String?
    let dogBio: String?
    let dog1 : String
    let dog2 : String

    let dog3 : String
    let dog4 : String

    
    enum CodingKeys: String, CodingKey {
        case dogName="dog_name"
        case dogBreed="dog_breed"
        case dogAge="dog_age"
        case dogGender="dog_gender"
        case ownerName="owner_name"
        case phoneNumber="phone_no"
        case avatarURL = "avatar_url"
        case dogBio = "dog_bio"
        case dog1 = "dog_pic1"
        case dog2 = "dog_pic2"
        case dog3 = "dog_pic3"
        case dog4 = "dog_pic4"
        
    }
}
