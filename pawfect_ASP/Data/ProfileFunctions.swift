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
    let website: String?
    let avatarURL: String?
    let petBio: String?
    
    enum CodingKeys: String, CodingKey {
        case dogName="dog_name"
        case dogBreed="dog_breed"
        case dogAge="dog_age"
        case dogGender="dog_gender"
        case ownerName="owner_name"
        case phoneNumber="phone_number"
        case website
        case avatarURL = "avatar_url"
        case petBio = "pet_bio"
    }
}
