import SwiftUI

struct DatingMainScreenView: View {
    @StateObject var homeController = HomeController()

    @State private var showAlert: Bool = false
    @State private var swipeDirection: String = ""
    @State private var noMoreCards: Bool = false

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all) // Background color
            VStack(alignment: .center) {
                if noMoreCards {
                    noMoreCardsView()
                } else {
                    cardsView()
                    likeDislikeButtons()
                }
            }
            .onAppear {
                Task {
                    await homeController.fetchAllPets()
                }
            }
        }
    }
    
    // Separate view for when no more cards are available
    private func noMoreCardsView() -> some View {
        Text("No more pets available.")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .padding()
    }
    
    // Separate view for displaying cards
    private func cardsView() -> some View {
        ZStack {
            ForEach(homeController.petProfiles.indices, id: \.self) { index in
                DatingMainCardView(
                    dogName: homeController.petProfiles[index].dogName ?? "Unknown",
                    dogBreed: homeController.petProfiles[index].dogBreed ?? "Unknown Breed",
                    age: Int(homeController.petProfiles[index].dogAge ?? "0") ?? 0,
                    gender: homeController.petProfiles[index].dogGender ?? "Unknown Gender",
                    currentImageIndex: 0,
                    imageNames: [homeController.petProfiles[index].image1 ?? "", homeController.petProfiles[index].image2 ?? "", homeController.petProfiles[index].image3 ?? "", homeController.petProfiles[index].image4 ?? ""],
                    noMoreCards: $noMoreCards,
                    remainingCards: $homeController.petProfiles,
                    showAlert: $showAlert,
                    swipeDirection: $swipeDirection,
                    index: index
                )
            }
        }
    }

    // Separate view for like and dislike buttons
    private func likeDislikeButtons() -> some View {
        LikeDislikeButton(
            showAlert: $showAlert,
            showDirection: $swipeDirection,
            remainingCards: $homeController.petProfiles,
            noMoreCards: $noMoreCards,
            index: 0 // This targets the first card
        )
    }
}

struct DatingMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DatingMainScreenView()
    }
}
