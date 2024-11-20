import SwiftUI

struct LikeDislikeButton: View {
    @Binding var showAlert: Bool
    @Binding var showDirection: String
    @State private var isPressedLeft: Bool = false
    @State private var isPressedRight: Bool = false
    @Binding var remainingCards: [PetProfile]
    @Binding var noMoreCards: Bool
    @State var index: Int

    var body: some View {
        HStack(alignment: .center) {
            // Dislike Button
            Image(systemName: "xmark")
                .font(.largeTitle)
                .foregroundColor(.green)
                .frame(width: screenWidth / 7, height: screenWidth / 7)
                .background(Circle().fill(Color.white))
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                .scaleEffect(isPressedLeft ? 0.9 : 1.0)
                .animation(.spring(), value: isPressedLeft)
                .onTapGesture {
                    isPressedLeft = true
                    removeCard(index: index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressedLeft = false
                        showAlert = true
                        showDirection = "Left"
                    }
                }

            // Like Button
            Image(systemName: "heart.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
                .frame(width: screenWidth / 7, height: screenWidth / 7)
                .background(Circle().fill(Color.white))
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                .scaleEffect(isPressedRight ? 0.9 : 1.0)
                .onTapGesture {
                    isPressedRight = true
                    removeCard(index: index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressedRight = false
                        showAlert = true
                        showDirection = "Right"
                    }
                }
        }
    }

    private func removeCard(index: Int) {
        if index < remainingCards.count {
            remainingCards.remove(at: index)
            if remainingCards.isEmpty {
                noMoreCards = true
            }
        }
    }
}

struct LikeDislikeButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var showAlert = false
        @State var swipeDirection = ""
        @State var remainingCards: [PetProfile] = [
            PetProfile(
                id: "1",
                dogName: "Yeontan",
                dogBreed: "Labrador Retriever",
                dogAge: "2",
                dogGender: "Male",
                ownerName: "John Doe",
                petBio: "Friendly and loves to play!",
//                /*avatarURL*/: "dog"
                image1: "dog"
            )
        ]
        @State var noMoreCards = false

        return LikeDislikeButton(
            showAlert: $showAlert,
            showDirection: $swipeDirection,
            remainingCards: $remainingCards,
            noMoreCards: $noMoreCards,  // Moved `noMoreCards` before `index` to match the initializer
            index: 0
        )
    }
}
