import SwiftUI
import PhotosUI

struct ChatView: View {
    let pet: Pet
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 1
    @Namespace private var animation

    // Improved color palette with gradient
    var primaryGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255), Color(red: 195 / 255, green: 55 / 255, blue: 100 / 255)]), startPoint: .top, endPoint: .bottom)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    var body: some View {
        VStack {
            // Animated image with interactive scaling and fading
            Image(pet.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400) // Adjusted for better proportionality
                .scaleEffect(scale)
                .opacity(opacity)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        scale = scale == 0.8 ? 1.0 : 0.8
                        opacity = opacity == 0.5 ? 1.0 : 0.5
                    }
                }
                .padding(.top, 30)

            // Contact details section with smooth transition
            Text("Contact Details")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
//                .foregroundStyle(primaryGradient)
                .padding(.top, 10)
                .transition(.opacity)
                .animation(.easeIn(duration: 1.0), value: opacity)
//
//            Spacer(minLength: 20)

            // Pet name with refined animation
            Text(pet.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(primaryGradient)
                .foregroundColor(Color.black)
                .matchedGeometryEffect(id: "petName", in: animation)
                .transition(.asymmetric(insertion: .move(edge: .leading).combined(with: .opacity),
                                        removal: .move(edge: .trailing).combined(with: .opacity)))
                .animation(.spring(), value: scale)

//            Spacer(minLength: 20)

            // Pet phone with dynamic scaling
            Text(pet.phone)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(primaryGradient)
                .scaleEffect(scale)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5), value: scale)
        }
        .padding(.horizontal)
        .background(secondaryColor)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
