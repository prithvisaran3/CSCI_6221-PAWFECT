import SwiftUI
import UIKit

struct ProfilePhotoBioView: View {
    @State private var profileImages: [UIImage] = []
    @State private var isImagePickerPresented = false
    @State private var selectedImageIndex: Int? = nil
    @Binding var bio: String
    var body: some View {
        ZStack {
            Color(screenSecondaryColor)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                    VStack {
                        ForEach(0..<4, id: \.self) { index in
                            if profileImages.count > index {
                                // Display the uploaded image in a rectangular thumbnail
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
                TextEditor(text: $bio)
                    .frame(width: screenWidth - 60, height: 150)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        Text("Write a short bio...")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 5),
                        alignment: .topLeading
                    )
                    .padding(.horizontal, 20)
                
                Button(action: {
                    // Submit final data here
                    print("Profile Submitted")
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
//            .padding(.top, 30)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            if let selectedIndex = selectedImageIndex {
                ImagePicker(selectedImage: Binding(
                    get: {
                        return profileImages[safe: selectedIndex]
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
    }
}
extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
