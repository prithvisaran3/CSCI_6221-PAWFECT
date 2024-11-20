////
////  SplashScrenView.swift
////  pawfect_ASP
////
////  Created by Kavya Varshini Anburasu on 19/11/24.
////
//
//import SwiftUI
//
//struct SplashScreenView: View {
//    @State private var isActive = false
//    @State private var size = 0.8
//    @State private var opacity = 0.5
//
//    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
//    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)
//
//    var body: some View {
//        if isActive {
//            DatingMainScreenView() // Navigates to the main app view
//        } else {
//            VStack {
//                Spacer()
//
//                // Logo and app name
//                VStack {
//                    Image("logo") // Ensure your project contains an image asset named 'logo'
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                        .scaleEffect(size)
//                        .opacity(opacity)
//                        .onAppear {
//                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
//                                size = 1.1
//                                opacity = 1.0
//                            }
//                        }
//
//                    Text("Pawfect!")
//                        .font(.largeTitle)
//                        .fontWeight(.medium)
//                        .foregroundColor(primaryColor)
//                        .padding(.top, 10)
//                }
//
//                Spacer()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(secondaryColor.ignoresSafeArea())
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Changed from 3 to 2 seconds
//                    withAnimation {
//                        isActive = true
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct SplashScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreenView()
//    }
//}
