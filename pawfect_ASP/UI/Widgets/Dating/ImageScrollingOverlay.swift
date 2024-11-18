//
//  ImageScrollingOverlay.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/13/24.
//

import SwiftUI
import SwiftData

struct ImageScrollingOverlay: View {
    @Binding var currentImageIndex: Int
    let imageCount: Int
//    init(currentImageIndex: Int) {
//        _currentImageIndex = State(initialValue: currentImageIndex
//        )
//    }
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.white.opacity(0.01))
                .padding([.bottom], 10)
                .onTapGesture {
                    updateCurrentImageIndex(increment: false)
                }
            Spacer()
            Rectangle()
                .fill(Color.white.opacity(0.01))
                .padding([.bottom], 10)
                .onTapGesture {
                    updateCurrentImageIndex(increment: true)
                }
        }
        .padding([.leading, .trailing], 10)
        
    }
}

private extension ImageScrollingOverlay {
     func updateCurrentImageIndex(increment: Bool){
        if increment {
            guard currentImageIndex < imageCount - 1 else { return }
            currentImageIndex += 1
        }
        else {
            guard currentImageIndex > 0 else { return }
            currentImageIndex -= 1
        }
    }
}


#Preview {
    @Previewable @State var previewImageIndex = 0
    ImageScrollingOverlay(
        currentImageIndex: $previewImageIndex, imageCount: 3
    )
}
