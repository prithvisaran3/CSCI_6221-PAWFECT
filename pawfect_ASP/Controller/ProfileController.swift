//
//  ProfileController.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 11/16/24.
//

import SwiftUI
import Supabase
import PhotosUI

@MainActor
@Observable
class ProfileController{
    var username = ""
    var fullName = ""
    var website = ""
    var isLoading = false
    var imageSelection : PhotosPickerItem?
    var avatarImage : AvatarImage?
    
    func toggleLoadingState(){
        withAnimation{
            
        }
    }
    
    func getInitialProfile() async{
        do{
            let currentUser =   try await supabase.auth.session.user
            let profile: Profile = try await supabase
                .from("profiles")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            
            username = profile.username ?? ""
            fullName = profile.fullName ?? ""
            website = profile.website ?? ""
            
            if let avatarURL = profile.avatarURL, !avatarURL.isEmpty{
                try await downloadImage(path: avatarURL)
            }
            
            
        }catch{
            debugPrint("Error fetching profile: \(error)")
        }
        
    }
    
    func updateProfile() async{
        Task{
            toggleLoadingState()
            
            defer{ toggleLoadingState()}
            do{
                let imageURL = try await uploadImage()
                
                let currentUser =   try await supabase.auth.session.user
                
                let updatedProfile = Profile(username: username, fullName: fullName, website: website, avatarURL: imageURL)
                
                try await supabase.from("profiles")
                    .update(updatedProfile)
                    .eq("id", value: currentUser.id)
                    .execute()
            }catch{
                debugPrint("Failed to update profile \(error)")
            }
        }
    }
    
    func signOut() async{
        Task {
            do{
                try await supabase.auth.signOut()
            }catch{
                debugPrint("Signout failed \(error)")
            }
        }
    }
    func loadTransferrable (from imageSelection : PhotosPickerItem){
        Task{
            do{
                avatarImage = try await imageSelection.loadTransferable(type: AvatarImage.self)
                
            }catch{
                debugPrint("Failed to load Transferrable \(error)")
            }
        }
    }
    
    private func downloadImage(path: String)async throws{
        let data = try await supabase.storage.from("avatars").download(path: path)
        avatarImage = AvatarImage(data: data)
    }
    
    private func uploadImage() async throws -> String? {
        guard let data = avatarImage?.data else { return nil }
        
        let filePath = "\(UUID().uuidString).jpeg"
        let storageBucket = supabase.storage.from("avatars")
        try await storageBucket.upload(path: filePath, file: data)
        
        return filePath
    }

    
}
