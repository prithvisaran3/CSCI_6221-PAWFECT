import SwiftUI

struct ChatListView: View {
    
    
    let pets = [
        Pet(name: "Mona", imageName: "dog", phone: "7038983773"),
        Pet(name: "Charlie", imageName: "Dog-1", phone: "7098983773"),
        Pet(name: "Bella", imageName: "Dog-2", phone: "7038983773")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Matched!")
                  //  .font(.largeTitle)
                    .bold()
                    .font(.custom("Andina Demo", size: 32))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(.top, 10)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(pets) { pet in
                            NavigationLink(destination: ChatView(pet: pet)) {
                                HStack {
                                    Image(pet.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color("PrimaryColor"), lineWidth: 2))
                                    
                                    Text(pet.name)
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
            .background(Color.white.ignoresSafeArea())
        }
    }
}

struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let phone : String
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
