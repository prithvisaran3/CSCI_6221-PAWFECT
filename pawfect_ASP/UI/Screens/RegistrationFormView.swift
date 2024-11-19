import SwiftUI

struct RegistrationFormView: View {
    // Shared State Variables
    @State private var dogName: String = ""
//    @State private var medicalRecords: String = ""
    @State private var ownerName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var selectedBreed: String = "Select Breed"
    @State private var age: String = ""
    @State private var phoneNumber: String = ""
    @State private var phoneNumberValid: Bool = true
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var selectedGender: String = ""
    @State private var bio: String = ""
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
                        TextField("Owner Name", text: $ownerName)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
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
                                TextField("Confirm Password", text: $confirmPassword)
                            } else {
                                SecureField("Confirm Password", text: $confirmPassword)
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
                    
                    
                    NavigationLink(destination: RegistrationAdditionalView(
                        selectedBreed: $selectedBreed,
                        age: $age,
                        phoneNumber: $phoneNumber,
                        phoneNumberValid: $phoneNumberValid,
                        dogName: $dogName, selectedGender: $selectedGender, bio: $bio, breeds: breeds
                    )) {
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



struct RegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView()
    }
}
