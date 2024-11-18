//
//  DatingUserCardsTapIndicator.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/14/24.
//

import SwiftUI
import SwiftData

struct DatingUserCardsTapIndicator: View {
    let currentImageIndex: Int
    let imageCount: Int
    var body: some View {
        HStack {
            ForEach(0..<imageCount, id: \.self) { index in
                Capsule()
                    .foregroundStyle(currentImageIndex == index ? screenPrimaryColor : screenSecondaryColor)
                    .frame(width: 15, height: 15)
            }
        }
    }
}

#Preview {
    DatingUserCardsTapIndicator(
        currentImageIndex: 0, imageCount: 3
    )
}
