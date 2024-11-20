import SwiftUI
import UIKit

struct ProfilePhotoBioView: View {
    @ObservedObject var authController: AuthController
    @State private var profileImages: [UIImage] = []
    @State private var isImagePickerPresented = false
    @State private var selectedImageIndex: Int? = nil
    @State private var isSignedUp = false  // State to track if the user has successfully signed up
    @State private var navigateToRoot = false // State to navigate to root after signup

    var body: some View {
        NavigationStack {
            ZStack {
                Color(screenSecondaryColor)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack {
                        // Loop for uploading/displaying profile images (maximum 4)
                        ForEach(0..<4, id: \.self) { index in
                            if profileImages.count > index {
                                Image(uiImage: profileImages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .cornerRadius(8)
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                            } else {
                                Button(action: {
                                    selectedImageIndex = index
                                    isImagePickerPresented = true
                                }) {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: screenWidth - 40, height: 90)
                                        .overlay(
                                            Text("Add Photo")
                                                .foregroundColor(screenPrimaryColor)
                                                .bold()
                                        )
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding(.top, 0)

                    // Bio TextEditor
                    TextEditor(text: $authController.bio)
                        .frame(width: screenWidth - 60, height: 150)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                if authController.bio.isEmpty {
                                    Text("Write a short bio...")
                                        .foregroundColor(.gray)
                                        .padding(.horizontal, 5)
                                        .padding(.top, 8)
                                }
                            },
                            alignment: .topLeading
                        )
                        .padding(.horizontal, 20)

                    // Register Button
                    Button(action: {
                        Task {
                            await signupAndNavigate()
                        }
                    }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(screenPrimaryColor))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)

                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                if let selectedIndex = selectedImageIndex {
                    ImagePicker(selectedImage: Binding(
                        get: {
                            return profileImages.indices.contains(selectedIndex) ? profileImages[selectedIndex] : nil
                        },
                        set: { newImage in
                            if let image = newImage {
                                if profileImages.count > selectedIndex {
                                    profileImages[selectedIndex] = image
                                } else {
                                    profileImages.append(image)
                                }
                            }
                        }
                    ))
                }
            }
            .navigationDestination(isPresented: $navigateToRoot) {
                LoginFormView() // Replace with the root view you want to navigate to after signup (e.g., LoginView or HomeView)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // Signup Function with Navigation Handling
    private func signupAndNavigate() async {
        await authController.signup()
        
        switch authController.authResult {
        case .success:
            // Set navigateToRoot to true to trigger the navigation to LoginView/HomeView
            navigateToRoot = true
        case .failure(let error):
            print("Signup failed: \(error.localizedDescription)")
            authController.errorMessage = error.localizedDescription
            authController.showAlert = true
        case .none:
            // Handle if authResult is still nil (optional case)
            print("Signup result is not available")
        }
    }
}
