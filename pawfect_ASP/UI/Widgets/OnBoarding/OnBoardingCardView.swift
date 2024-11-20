//
//  OnBoardingView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 10/8/24.
//

//
//  OnBoardingView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 10/8/24.
//
import SwiftUI

struct OnBoardingCardView: View {
    var mainText: String
    var subText: String
    var imageName: String

    init(mainText: String, subText: String, imageName: String) {
        self.mainText = mainText
        self.subText = subText
        self.imageName = imageName
    }

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            
            
            // Dog Image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth - 60, height: screenHeight / 2.2)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                .padding(.top, 50)
                .padding(.bottom, 20)

            // Main Text
            Text(mainText)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("PrimaryColor"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)

            
            // Sub Text
            Text(subText)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("PrimaryColor").opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SecondaryColor").ignoresSafeArea())
        .animation(.easeInOut, value: mainText)
    }
}


