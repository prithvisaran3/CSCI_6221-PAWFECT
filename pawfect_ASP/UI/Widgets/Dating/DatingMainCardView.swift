//
//  DatingMainCardView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/12/24.
//

import SwiftUI

struct DatingMainCardView: View {
    @State private var degrees: Double = 0
    @State private var xOffset: Double = 0
    @State private var dogName: String
    @State private var dogBreed: String
    @State private var age: Int
    @State private var gender: String
    @State private var currentImageIndex: Int = 0
    @State private var imageName: [String]
    @Binding var noMoreCards: Bool
    @Binding var remainingCards: [String]
    @Binding private var showAlert: Bool
    @Binding private var swipeDirection: String
    @State var index: Int = 0
    init(imageName: [String], dogName: String, dogBreed: String, age: Int, gender: String, currentImageIndex: Int, noMoreCards: Binding<Bool>, remainingCards: Binding<[String]>, index: Int, showAlert: Binding<Bool>, swipeDirection: Binding<String>) {
        self.dogName = dogName
        self.dogBreed = dogBreed
        self.age = age
        self.gender = gender
        self.imageName = imageName
        self.currentImageIndex = currentImageIndex
        _remainingCards = remainingCards
        _noMoreCards = noMoreCards
        self.index = index
        _swipeDirection = swipeDirection
        _showAlert = showAlert
    }
    var body: some View {
        ZStack(alignment: .bottom)
        {
            
            ZStack(alignment: .top){
                
                DatingCardView(imageName: imageName[currentImageIndex])
                    .overlay(
                        ImageScrollingOverlay(
                            currentImageIndex: $currentImageIndex, imageCount: imageName.count
                        )
                    )
                DatingUserCardsTapIndicator(currentImageIndex: currentImageIndex, imageCount: imageName.count)
                    .padding(.all, 10)
            }
            UserInfoView(
                dogName: dogName, dogBreed: dogBreed,  age: age, gender: gender
            )
        }
        .frame(width: screenWidth-20,height: screenHeight/1.3)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .gesture(
            DragGesture().onChanged({
                value in withAnimation(.snappy){
                    xOffset = value.translation.width
                    degrees = Double(value.translation.width/25)
                }
            }).onEnded({
                value in OnDragEnd(value)
            })
        )
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
}

extension DatingMainCardView {
    func OnDragEnd(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) < 200 {
            returnToOriginalPosition()
            return
        }
        if width >= 200 {
            swipeRight()
            swipeDirection = "Right"
            showAlert = true
        }
        else
        {
            swipeLeft()
            swipeDirection = "Left"
            showAlert = true
        }
        if noMoreCards {
            return
        }
        else {
            removeCard(index: index)
        }
    }
}

extension DatingMainCardView {
    private func removeCard(index: Int) {
        remainingCards.remove(at: index)
        
        if remainingCards.isEmpty {
            noMoreCards = true
        }
    }
}

#Preview {
    @Previewable @State var noMoreCards: Bool = false
    @Previewable @State var remainingCards: [String] = ["User 1", "User 2", "User 3"]
    @Previewable @State var showAlert: Bool = false
    @Previewable @State var swipeDirection: String = ""
    DatingMainCardView(imageName: ["dog", "Dog-1", "Dog-2", "Dog-3"], dogName: "Yeontan", dogBreed: "Labrador Retriever", age: 22, gender: "Male", currentImageIndex: 0, noMoreCards: $noMoreCards, remainingCards: $remainingCards, index: 0, showAlert: $showAlert, swipeDirection: $swipeDirection)
}
