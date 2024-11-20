import SwiftUI

struct RegistrationFormView: View {
    @StateObject var authController = AuthController()  // Create the StateObject

    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    let breeds = ["Select Breed", "Labrador", "German Shepherd", "Bulldog", "Beagle", "Poodle"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(screenSecondaryColor)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(15)
                        .background(screenPrimaryColor)
                        .clipShape(Circle())
                        .foregroundColor(screenSecondaryColor)
                    
                    VStack(spacing: 15) {
                        TextField("Owner Name", text: $authController.ownerName)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        TextField("Email", text: $authController.signUpEmail)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Password", text: $authController.signUpPassword)
                            } else {
                                SecureField("Password", text: $authController.signUpPassword)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Text(isPasswordVisible ? "Hide" : "Show")
                                    .font(.footnote)
                                    .foregroundColor(screenPrimaryColor)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        
                        HStack {
                            if isConfirmPasswordVisible {
                                TextField("Confirm Password", text: $authController.confirmPassword)
                            } else {
                                SecureField("Confirm Password", text: $authController.confirmPassword)
                            }
                            Button(action: {
                                isConfirmPasswordVisible.toggle()
                            }) {
                                Text(isConfirmPasswordVisible ? "Hide" : "Show")
                                    .font(.footnote)
                                    .foregroundColor(screenPrimaryColor)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .padding(20)
                    .background(Color(screenSecondaryColor))
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
                    
                    NavigationLink(destination: RegistrationAdditionalView(authController: authController, breeds: breeds)) {
                        Text("Next")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(screenPrimaryColor))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
