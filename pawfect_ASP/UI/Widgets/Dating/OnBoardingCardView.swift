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
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    var message: String
    var paraMessage: String
    var imageName: String
    init(message: String, paraMessage: String, imageName: String) {
        self.message = message
        self.paraMessage = paraMessage
        self.imageName = imageName
    }
    var body : some View {
        VStack(alignment:.center) {
            Image(imageName)
                .resizable()
                .frame(width: screenWidth-60,height: screenHeight/2)
//                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(.bottom, 20)
                .padding(.top, 0)
            Text(message)
                .padding(.top, 0)
                .padding(.bottom, 2)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom,2)
                .frame(width: screenWidth-60)
            Text(paraMessage)
                .font(.body)
                .lineLimit(2)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .frame(width: screenWidth - 20)
            
        }
    }
}


