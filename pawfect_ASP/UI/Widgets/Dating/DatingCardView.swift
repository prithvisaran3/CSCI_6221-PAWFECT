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

struct DatingCardView: View {
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    //    var message: String
    //    var paraMessage: String
    var imageName: String
    init(imageName: String) {
        //        self.message = message
        //        self.paraMessage = paraMessage
        self.imageName = imageName
    }
    var body : some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
    }
}

#Preview {
    DatingCardView(imageName: "dog")
}


