import SwiftUI

struct DatingMainScreenView: View {
    @StateObject var homeController = HomeController()
      @State private var showAlert: Bool = false
      @State private var swipeDirection: String = ""
      @State private var noMoreCards: Bool = false
      @State private var showSplash: Bool = true // State to control splash screen visibility

      var body: some View {
          if showSplash {
              SplashScreenView(showSplash: $showSplash)
            
          } else {
              mainContentView
          }
      }

      // The main content of DatingMainScreenView
      private var mainContentView: some View {
          ZStack {
              Color(screenSecondaryColor).opacity(0.5).ignoresSafeArea()// Background color
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
                    dogBio: homeController.petProfiles[index].petBio ?? "No bio, swipe right",
                    ownerName: homeController.petProfiles[index].ownerName ?? "Unknown Owner",
                    age: Int(homeController.petProfiles[index].dogAge ?? "0") ?? 0,
                    
                    
                    gender: homeController.petProfiles[index].dogGender ?? "Unknown Gender",
                    currentImageIndex: 0,
                    imageNames:  [homeController.petProfiles[index].image1 ?? "", homeController.petProfiles[index].image2 ?? "", homeController.petProfiles[index].image3 ?? "", homeController.petProfiles[index].image4 ?? ""],
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

struct SplashScreenView: View {
    @Binding var showSplash: Bool
    @State private var size = 0.8
    @State private var opacity = 0.5

    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    var body: some View {
        VStack {
            Spacer()

            // Logo and app name
            VStack {
                Image("logo") // Ensure your project contains an image asset named 'logo'
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            size = 1.1
                            opacity = 1.0
                        }
                    }
                
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(secondaryColor.ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
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
