import SwiftUI

struct RegistrationAdditionalView: View {
    @ObservedObject var authController: AuthController  // Pass the existing instance

    let breeds: [String]
    
    var body: some View {
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
                    TextField("Dog Name", text: $authController.dogName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    
                    Picker(selection: $authController.selectedBreed, label: Text("Select Breed")) {
                        ForEach(breeds, id: \.self) { breed in
                            Text(breed)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    
                    Picker("Select Gender", selection: $authController.selectedGender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)

                    TextField("Age", text: $authController.age)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                    
                    TextField("Phone Number", text: $authController.phoneNumber, onEditingChanged: { _ in
                        validatePhoneNumber(authController.phoneNumber)
                    })
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .keyboardType(.phonePad)
                    if !authController.phoneNumberValid {
                        Text("Please enter a valid 10-digit phone number.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding(20)
                .background(Color(screenSecondaryColor))
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)

                NavigationLink(destination: ProfilePhotoBioView(authController: authController)) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(screenPrimaryColor))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func validatePhoneNumber(_ number: String) {
        let phoneRegex = "^[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        authController.phoneNumberValid = predicate.evaluate(with: number)
    }
}
