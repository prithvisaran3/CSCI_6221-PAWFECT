//
//  AuthController.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 11/12/24.
//

import Foundation
import Supabase
import SwiftUI

@Observable
class AuthController : ObservableObject{
    var userEmail=""
    var userPassword=""
    var isLoading=false
    var authResult:Result<Void,Error>?{
        didSet{
            if case .failure = authResult{
                showAlert=true
            }
        }
    }
    var showAlert=false
    var errorMessage : String?
    
    private func toggleLoadingState(){
        withAnimation{
            isLoading.toggle()
        }
    }
    @MainActor
    func login() async{
        toggleLoadingState()
        defer{toggleLoadingState()}
        
        do{
            try await supabase.auth.signIn(email: userEmail, password: userPassword)
            authResult = .success(())
        }catch{
            authResult = .failure(error)
            errorMessage = error.localizedDescription
            
        }
        
    }
    
}
