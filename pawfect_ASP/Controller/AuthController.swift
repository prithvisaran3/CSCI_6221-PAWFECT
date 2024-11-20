import Foundation
import Supabase
import SwiftUI

@Observable
class AuthController: ObservableObject {
    var dogName: String = ""
    //    @State private var medicalRecords: String = ""
    
    var confirmPassword: String = ""
    var selectedBreed: String = ""
    var age: String = ""
    var phoneNumber: String = ""
    var phoneNumberValid: Bool = true
    
    var selectedGender: String = ""
    var bio: String = ""
    
    
    
    
    var userEmail = ""
    var signUpEmail = ""
    var signUpPassword = ""
    var userPassword = ""
    var phoneNo: String? = nil       // Add phone number field
    var ownerName = ""               // Add owner name field
    var address = ""                 // Add address field
    var country = ""                 // Add country field
    var isLoading = false
    var authResult: Result<Void, Error>? {
        didSet {
            if case .failure = authResult {
                showAlert = true
            }
        }
    }
    var showAlert = false
    var errorMessage: String?
    
    private func toggleLoadingState() {
        withAnimation {
            isLoading.toggle()
        }
    }
    
    @MainActor
    func login() async {
        toggleLoadingState()
        defer { toggleLoadingState() }
        
        do {
            try await supabase.auth.signIn(email: userEmail, password: userPassword)
            authResult = .success(())
            
            // Update the user's entry in the specified table after successful login
            //            let session = try await supabase.auth.session
            //            let userId = session.user.id
            //            await updateUserTable(with: userId)
        } catch {
            authResult = .failure(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func signup() async {
        toggleLoadingState()
        defer { toggleLoadingState() }
        
        do {
            print("Attempting to sign up user with email: \(signUpEmail)")
            let session = try await supabase.auth.signUp(email: signUpEmail, password: signUpPassword)
            print("Successfully signed up. Session: \(session)")
    
            authResult = .success(())
            
            
            // Update the user's entry in the specified table after successful signup
            let userId = session.user.id
            await updateUserTable(with: userId)
        } catch {
            print("Signup failed: \(error.localizedDescription)")
            authResult = .failure(error)
            errorMessage = error.localizedDescription
        }
    }

    
    
    
    @MainActor
    func logout() async {
        do {
            try await supabase.auth.signOut()
            print("Successfully signed out.")
        } catch {
            print("Failed to sign out: \(error)")
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    private func updateUserTable(with userId: UUID) async {
        struct UserEntry: Encodable {
            let id: String
            let email_id: String
            let phone_no: String?  // Phone number is optional to prevent empty string issues
            let created_at: String
            let owner_name: String
            let address: String
            let country: String
            let dog_name: String
            let dog_breed: String
            let dog_age: String
            let dog_gender: String
            let dog_bio: String
        }
        
        do {
            // Ensure optional phone number is provided, or leave it as nil
            let userEntry = UserEntry(
                
                id: userId.uuidString,
                email_id: signUpEmail,
                phone_no: phoneNumber != "" ? phoneNumber : nil,
                created_at: ISO8601DateFormatter().string(from: Date()),
                owner_name: ownerName,
                address: address,
                country: country,
                dog_name: dogName,
                dog_breed: selectedBreed,
                dog_age: age,
                dog_gender: selectedGender,
                dog_bio: bio
            )
            
            try await supabase
                .from("users") // Replace with the correct table name
                .insert([userEntry]) // Insert method now takes an array of UserEntry objects
                .execute()
            
            print("User ID \(userId) successfully added to the table.")
        } catch {
            print("Failed to update user table: \(error)")
            errorMessage = "Failed to update user data: \(error.localizedDescription)"
        }
    }
}
