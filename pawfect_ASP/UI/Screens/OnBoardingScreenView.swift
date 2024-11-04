//
//  OnBoardingScreenView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 10/10/24.
//

import SwiftUI

struct OnBoardingScreenView : View {
    @State private var xOffset: CGFloat = 0
//    @State private var degrees: Double = 0
    @State var message: String
    @State var paraMessage: String
    var imageName: String
    var onBoardingCard: OnBoardingCardView
    init(message: String, paraMessage: String, imageName: String) {
        self.message = message
        self.paraMessage = paraMessage
        self.imageName = imageName
        self.onBoardingCard = OnBoardingCardView(message: message, paraMessage: paraMessage, imageName: imageName)
    }
   
    var body: some View {
        onBoardingCard.body
//                .offset(x: xOffset)
//                .gesture(
//                    DragGesture().onChanged({
//                        value in withAnimation(.snappy){
//                            xOffset = value.translation.width
//                        }
//                    }).onEnded({
//                        value in OnDragEnd(value)
//                    })
//                )
    }
}

//extension OnBoardingScreenView {
//    func OnDragEnd(_ value: _ChangedGesture<DragGesture>.Value) {
//        let width = value.translation.width
//        if abs(width) > 100 {
//            xOffset = 0
//        }
//    }
//}

//#Preview {
//    OnBoardingScreenView(message: "I am the title bro", paraMessage: "I am the default text and I will be in twooooo lines onlyyyyy", imageName: "puppy")
//}
