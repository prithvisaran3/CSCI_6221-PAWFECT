import SwiftUI

struct ChatListView: View {
    @StateObject var chatController = HomeController() // Instantiate HomeController
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Matched!")
                    .bold()
                    .font(.custom("Andina Demo", size: 32))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(.top, 10)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(chatController.chatProfile) { pet in
                            NavigationLink(destination: ChatView(pet: Pet(name: pet.dogName ?? "Unknown", imageName: pet.image1 ?? "placeholder", phone: pet.phoneNumber ?? "N/A"))) {
                                HStack {
                                    AsyncImage(url: URL(string: pet.image1 ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color("PrimaryColor"), lineWidth: 2))
                                        case .failure:
                                            Image("placeholder")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color("PrimaryColor"), lineWidth: 2))
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    Text(pet.dogName ?? "Unknown")
                                        .font(.headline)
                                        .foregroundColor(Color("PrimaryColor"))
                                        .padding(.leading, 10)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color("SecondaryColor").opacity(0.3))
                                .cornerRadius(30)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                Task {
                    await chatController.matchChat()
                }
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}

struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let phone: String
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
