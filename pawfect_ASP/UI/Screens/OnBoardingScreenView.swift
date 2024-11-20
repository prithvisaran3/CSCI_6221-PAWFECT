//
//  OnBoardingScreenView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 10/10/24.
//

import SwiftUI

struct OnBoardingScreenView: View {
    @State private var xOffset: CGFloat = 0
    @State var imageName: String
    var onBoardingCard: OnBoardingCardView

    init(mainText: String, subText: String, imageName: String) {
        self.imageName = imageName
        self.onBoardingCard = OnBoardingCardView(mainText: mainText, subText: subText, imageName: imageName)
    }

    var body: some View {
        onBoardingCard.body
    }
}

#Preview {
    OnBoardingScreenView(mainText: "I am the title bro", subText: "Welcome to the app!", imageName: "puppy")
}
