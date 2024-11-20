import SwiftUI

struct DatingMainCardView: View {
    @StateObject var homeController = HomeController()
    @State private var degrees: Double = 0
    @State private var xOffset: Double = 0
    @State var dogName: String
    @State var dogBreed: String
    @State var age: Int
    @State var gender: String
    @State var currentImageIndex: Int = 0
    @State var imageNames: [String]
    @Binding var noMoreCards: Bool
    @Binding var remainingCards: [PetProfile]
    @Binding var showAlert: Bool
    @Binding var swipeDirection: String
    @State var index: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                DatingCardView(imageName: imageNames[currentImageIndex])
                    .overlay(
                        ImageScrollingOverlay(
                            currentImageIndex: $currentImageIndex,
                            imageCount: imageNames.count
                        )
                    )
                DatingUserCardsTapIndicator(currentImageIndex: currentImageIndex, imageCount: imageNames.count)
                    .padding(.all, 10)
            }
            UserInfoView(
                dogName: dogName,
                dogBreed: dogBreed,
                age: age,
                gender: gender
            )
        }
        .frame(width: screenWidth - 20, height: screenHeight / 1.3)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .gesture(
            DragGesture().onChanged({ value in
                withAnimation(.snappy) {
                    xOffset = value.translation.width
                    degrees = Double(value.translation.width / 25)
                }
            }).onEnded({ value in
                OnDragEnd(value)
            })
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Match Found!"),
                message: Text("You found a match with \(dogName)!"),
                dismissButton: .default(Text("Awesome!"))
            )
        }
    }
}

extension DatingMainCardView {
    func returnToOriginalPosition() {
        xOffset = 0
        degrees = 0
    }

    func swipeLeft() {
        xOffset = -500
        degrees = 12
    }

    func swipeRight() {
        xOffset = 500
        degrees = -12
    }

    func OnDragEnd(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) < 200 {
            returnToOriginalPosition()
            return
        }
        if width >= 200 {
            swipeRight()
            swipeDirection = "Right"

            // Check for the hardcoded ID match
            if index < remainingCards.count, remainingCards[index].id == "2dbcfd65-71bc-4aa0-a0d8-cfb2b6ff75f7" {
                homeController.matchUser = remainingCards[index].id
                showAlert = true // Show alert only for specific ID
            }
        } else {
            swipeLeft()
            swipeDirection = "Left"
        }
        
        if noMoreCards {
            return
        } else {
            removeCard(index: index)
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

struct DatingMainCardView_Previews: PreviewProvider {
    static var previews: some View {
        @State var noMoreCards = false
        @State var remainingCards: [PetProfile] = [
            PetProfile(id: "match-id", dogName: "Yeontan", dogBreed: "Labrador Retriever", dogAge: "2", dogGender: "Male", ownerName: "John Doe", petBio: "Friendly and loves to play!", image1: "dog", image2: "dog1", image3: "dog2"),
            PetProfile(id: "2", dogName: "Buddy", dogBreed: "Golden Retriever", dogAge: "3", dogGender: "Female", ownerName: "Jane Smith", petBio: "Loyal and friendly!", image1: "dog", image2: "dog1", image3: "dog2")
        ]
        @State var showAlert = false
        @State var swipeDirection = ""

        return DatingMainCardView(
            dogName: "Yeontan",
            dogBreed: "Labrador Retriever",
            age: 2,
            gender: "Male",
            currentImageIndex: 0,
            imageNames: ["dog", "Dog-1", "Dog-2", "Dog-3"],
            noMoreCards: $noMoreCards,
            remainingCards: $remainingCards,
            showAlert: $showAlert,
            swipeDirection: $swipeDirection,
            index: 0
        )
    }
}
