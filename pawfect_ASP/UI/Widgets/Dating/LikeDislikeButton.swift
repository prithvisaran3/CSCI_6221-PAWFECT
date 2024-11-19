//
//  LikeDislikeButton.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/15/24.
//

import SwiftUI
import SwiftData

struct LikeDislikeButton: View {
    @Binding var showAlert: Bool
    @Binding var showDirection: String
    @State private var isPressedLeft: Bool = false
    @State private var isPressedRight: Bool = false
    @Binding var remainingCards: [String]
    @Binding var noMoreCards: Bool
    @State var index: Int
    init(showAlert: Binding<Bool>, showDirection: Binding<String>, remainingCards: Binding<[String]>, index: Int, noMoreCards: Binding<Bool>) {
        _showAlert = showAlert
        _showDirection = showDirection
        _remainingCards = remainingCards
        self.index = index
        _noMoreCards = noMoreCards
    }
    public var body: some View {
        HStack(alignment: .center){
            Image(systemName: "xmark")
                .font(.largeTitle)
                .foregroundColor(.green)
                .frame(width: screenWidth/6, height: screenWidth/6)
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
            Image(systemName: "heart.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
                .frame(width: screenWidth/6, height: screenWidth/6)
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
}


extension LikeDislikeButton {
    private func removeCard(index: Int) {
        remainingCards.remove(at: index)
        if remainingCards.isEmpty {
            noMoreCards = true
        }
    }
}


#Preview() {
    @Previewable @State var showAlert: Bool = false
    @Previewable @State var swipeDirection: String = ""
    @Previewable @State var remainingCards: [String] = ["User 1", "User 2", "User 3"]
    @Previewable @State var noMoreCards: Bool = false
    LikeDislikeButton(
        showAlert: $showAlert,
        showDirection: $swipeDirection,
        remainingCards: $remainingCards,
        index: 0,
        noMoreCards: $noMoreCards//this wont do any change for now.
    )
}
