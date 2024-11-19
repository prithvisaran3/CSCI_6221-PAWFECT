import SwiftUI
import PhotosUI

struct ChatView: View {
    let pet: Pet
    @State private var messages: [Message] = [
        Message(content: "Hey! Wanna meet at the park?", isSentByUser: false),
        Message(content: "Sure! What time?", isSentByUser: true)
    ]
    @State private var messageText = ""
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        
        VStack {
            // Header Section
            HStack {
                Image(pet.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("PrimaryColor"), lineWidth: 1))
                
                Text(pet.name)
                    .font(.title2)
                    .foregroundColor(Color("PrimaryColor"))
                
                Spacer()
            }
            .padding()

            // Messages Section
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isSentByUser {
                                Spacer()
                                if let image = message.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 150, maxHeight: 150)
                                        .cornerRadius(15)
                                        .padding(.trailing, 10)
                                } else {
                                    Text(message.content ?? "")
                                        .padding()
                                        .background(Color("PrimaryColor"))
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .frame(maxWidth: 250, alignment: .trailing)
                                        .padding(.trailing, 10)
                                }
                            } else {
                                if let image = message.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 150, maxHeight: 150)
                                        .cornerRadius(15)
                                        .padding(.leading, 10)
                                } else {
                                    Text(message.content ?? "")
                                        .padding()
                                        .background(Color("SecondaryColor"))
                                        .foregroundColor(.black)
                                        .cornerRadius(15)
                                        .frame(maxWidth: 250, alignment: .leading)
                                        .padding(.leading, 10)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .padding(.top)

            // Input Section
            HStack {
                // Attach Button
                Button(action: { showPhotoPicker.toggle() }) {
                    Image(systemName: "paperclip")
                        .foregroundColor(Color("PrimaryColor"))
                        .padding()
                        .background(Color("SecondaryColor").opacity(0.3))
                        .clipShape(Circle())
                }

                // TextField
                TextField("Type a message...", text: $messageText)
                    .padding()
                    .background(Color("SecondaryColor").opacity(0.3))
                    .cornerRadius(20)

                // Send Button
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color("PrimaryColor"))
                        .padding()
                        .background(Color("SecondaryColor"))
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectedImage: $selectedImage, onImagePicked: handleImagePicked)
        }
    }

    // Handle sending a text message
    func sendMessage() {
        if !messageText.isEmpty {
            messages.append(Message(content: messageText, isSentByUser: true))
            messageText = ""
        }
    }

    // Handle adding an image to the chat
    func handleImagePicked(image: UIImage?) {
        if let image = image {
            messages.append(Message(image: image, isSentByUser: true))
        }
    }
}
