//
//  ProfileView.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 11/15/24.
//

import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    @Bindable var profileController = ProfileController()
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    HStack{
                        Group{
                            if let avatarImage =
                                profileController.avatarImage{
                                avatarImage.image
                                    .resizable()
                            }else{
                                Color.clear
                            }
                                
                        }
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        Spacer()
                        PhotosPicker(selection: $profileController.imageSelection, matching: .images,label: {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        })
                        
                    }
                }
                Section{
                    TextField("Username", text: $profileController.dogAge)
                        .textContentType(.username)
                        .autocapitalization(.none)
                    
                    TextField("Full Name", text: $profileController.dogName)
                        .textContentType(.name)
                        
                }
                
                Section {
                    Button("Update Profile") {
                        Task {
                            await profileController.updateProfile()
                        }
                    }
                    .bold()
                    
                    if profileController.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

            }
            .navigationTitle("Profiles")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Log Out", role: .destructive) {
                        Task {
                            await profileController.signOut()
                        }
                    }
                }

            })
            .onChange(of: profileController.imageSelection) { oldValue, newValue in
                if let newValue = newValue {
                    profileController.loadTransferrable(from: newValue)
                }
            }.task{
                await profileController.getInitialProfile()
            }


        }
    }
}

#Preview {
    ProfileScreen()
}
