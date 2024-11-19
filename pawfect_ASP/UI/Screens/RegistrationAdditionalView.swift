//
//  RegistrationAdditionalView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/19/24.
//

import SwiftUI

struct RegistrationAdditionalView: View {
    // Binding Variables to Receive Data from Previous Page
    @Binding var selectedBreed: String
    @Binding var age: String
    @Binding var phoneNumber: String
    @Binding var phoneNumberValid: Bool
//    @Binding var medicalRecords: String
    @Binding var dogName: String
    @Binding var selectedGender: String
    @Binding var bio: String
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
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        TextField("Dog Name", text: $dogName)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        Picker(selection: $selectedBreed, label: Text(selectedBreed)
                               //                           selectedBreed == "Select Breed" ? screenPrimaryColor : .black
                            .foregroundColor(screenPrimaryColor)) {
                                ForEach(breeds, id: \.self) { breed in
                                    Text(breed)
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedBreed == "Select Breed" ? Color.gray.opacity(0.6) : Color.clear, lineWidth: 0)
                            )
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Picker("Select Gender", selection: $selectedGender) {
                                Text("Male")
                                    .tag("Male")
                                Text("Female").tag("Female")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                            .background(.white)
                            .foregroundColor(screenPrimaryColor)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                        }
                        
                        TextField("Age", text: $age)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                        
                        
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("Phone Number", text: $phoneNumber, onEditingChanged: { _ in
                                validatePhoneNumber(phoneNumber)
                            })
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .keyboardType(.phonePad)
                            if !phoneNumberValid {
                                Text("Please enter a valid 10-digit phone number.")
                                    .font(.caption)
                                    .foregroundColor(screenPrimaryColor)
                            }
                        }
                    }
                    .padding(20)
                    .background(Color(screenSecondaryColor))
                    .cornerRadius(16)
                    .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
                    NavigationLink(destination: ProfilePhotoBioView(bio: $bio))
                    {
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
        }
    }
    
    func validatePhoneNumber(_ number: String) {
        let phoneRegex = "^[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        phoneNumberValid = predicate.evaluate(with: number)
    }
}
