import SwiftUI

struct DatingMainCardView: View {
    @StateObject var homeController = HomeController()
    @State private var degrees: Double = 0
    @State private var xOffset: Double = 0
    @State var dogName: String
    @State var dogBreed: String
    @State var dogBio: String
    @State var ownerName: String
    @State var age: Int
    @State var gender: String
    @State var currentImageIndex: Int = 0
    @State var imageNames: [String]
    @Binding var noMoreCards: Bool
    @Binding var remainingCards: [PetProfile]
    @Binding var showAlert: Bool
    @Binding var swipeDirection: String
    @State var index: Int
    
    let validIDs = [
        "4d2c8208-eed5-477f-8d8b-6112758adb53",
        "7c6a44fd-c6f2-4792-b986-bde059fe4f6c",
        "19199b75-a869-4828-bd5b-8e0720338d7b"
    ]
    
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
                gender: gender,bio: dogBio,ownerName: ownerName
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
                message: Text("You Found a Match!"),
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
        swipeDirection = "Right"
        
        if index < remainingCards.count {
            let matchedProfile = remainingCards[index]
            
            
            
            // Check for the hardcoded ID match and show alert
            if validIDs.contains(matchedProfile.id) {
                homeController.matchUser = matchedProfile.id
                ChatManager.shared.addMatch(profile: matchedProfile)
                showAlert = true // Show alert only for specific ID
            }
        }
    }
    
    func OnDragEnd(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) < 200 {
            returnToOriginalPosition()
            return
        }
        if width >= 200 {
            swipeRight()
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
