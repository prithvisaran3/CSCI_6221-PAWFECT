//
//  CardView.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 10/8/24.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack{
            Image(.dog)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth-20,height: screenHeight/1.45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    CardView()
}
