//
//  DatingMainScreenView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/15/24.
//

import SwiftUI
import SwiftData

struct DatingMainScreenView: View {
    @State var users: [String] = ["User 1", "User 2", "User 3"]
    @State var userImages: [[String]] = [["dog", "Dog-1", "Dog-2", "Dog-3"], ["Dog-1", "dog", "Dog-2", "Dog-3"], ["dog", "Dog-3", "dog", "Dog-3"]]
    @State var breeds: [String] = ["Puppy", "Labrador Retriever", "Pomeranian"]
    @State var ages: [Int] = [1, 2, 3]
    @State var genders: [String] = ["Male", "Female", "Male"]
    @State var noMoreCards: Bool = false
    @State var showAlert: Bool = false
    @State var swipeDirection: String = ""
    var body: some View {
        ZStack {
            screenSecondaryColor
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                if noMoreCards {
                    NavigationView{
                        ZStack {
                            Color.gray.opacity(0.8)
                                .edgesIgnoringSafeArea(.all)
                            VStack(spacing: 16) {
                                Text("Oops!")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("There are no more dogs available.")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                NavigationLink(destination: MainOnBoardingForm()) {
                                    Text("Go Back")
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(screenSecondaryColor)
                                        .foregroundColor(.gray)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(30)
                        .background(Color.black.opacity(0.9))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    }
                    .frame(width: screenWidth-20,height: screenHeight/1.3)
                }
                else {
                    ZStack {
                        ForEach(0..<users.count, id: \.self) { index in
                            DatingMainCardView(
                                imageName: userImages[index], dogName: users[index], dogBreed: breeds[index], age: ages[index], gender: genders[index], currentImageIndex: 0, noMoreCards: $noMoreCards, remainingCards: $users, index: index,
                                    showAlert: $showAlert,
                                    swipeDirection: $swipeDirection
                            )
                            .alert(swipeDirection == "Right" ? "You found a Match!" : "You rejected one!", isPresented: $showAlert) {                Button("OK", role: .cancel) {}
                            }
                        }
                    }
                    LikeDislikeButton(showAlert: $showAlert, showDirection: $swipeDirection, remainingCards: $users, index: 0, noMoreCards: $noMoreCards)
                }
                
            }
            .frame(width: screenWidth - 20, height: screenHeight / 3)
        }
    }
}

#Preview {
    DatingMainScreenView()
}
