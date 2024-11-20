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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(swipeDirection == "Right" ? "You found a Match!" : "Swipe action"),
                message: Text(swipeDirection == "Right" ? "You have matched with a pet!" : "You swiped left!"),
                dismissButton: .default(Text("OK"))
            )
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
                    imageNames: [homeController.petProfiles[index].avatarURL ?? "pawprint.fill"],
                    noMoreCards: $noMoreCards,
                    remainingCards: $homeController.petProfiles,
                    showAlert: $showAlert,
                    swipeDirection: $swipeDirection,
                    index: index
                )
                .onChange(of: swipeDirection) { oldValue, newValue in
                    if newValue == "Right" || newValue == "Left" {
                        handleSwipe(at: index, direction: newValue)
                    }
                }
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

    // Function to handle swiping actions
    private func handleSwipe(at index: Int, direction: String) {
        guard index < homeController.petProfiles.count else { return }

        let currentUserId = UUID() // This should be the logged-in user's ID.
        let swipedUserId = UUID(uuidString: homeController.petProfiles[index].id) ?? UUID()

        Task {
            await homeController.handleSwipe(currentUserId: currentUserId, swipedUserId: swipedUserId, direction: direction)

            // Remove the card after swipe action is performed.
            if index < homeController.petProfiles.count {
                homeController.petProfiles.remove(at: index)
                if homeController.petProfiles.isEmpty {
                    noMoreCards = true
                }
            }
        }
    }
}

struct DatingMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DatingMainScreenView()
    }
}
