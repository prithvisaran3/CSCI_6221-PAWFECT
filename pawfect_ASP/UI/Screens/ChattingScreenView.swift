//
//  ChattingScreenView.swift
//  pawfect_ASP
//
//  Created by Chandan Kumar r on 11/20/24.
//

import SwiftUI

struct ChatScreenView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var profileData = ProfileController()

    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    var body: some View {

            VStack {
                Spacer()
                VStack {
                    Image("logo") //
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                size = 1.1
                                opacity = 1.0
                            }
                        }

                    Text("Contact details")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(primaryColor)
                        .padding(.top, 10)
                }
                .padding()
                Text("\(profileData.phoneNumber)")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(primaryColor)
                    .padding(.top, 10)
            

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(secondaryColor.ignoresSafeArea())
            
            }
        }


#Preview {
    ChatScreenView()
}
