//
//  CardSwipeOverlay.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 10/15/24.
//

import SwiftUI

public struct OnBoardingSwipeView: View {
    @State var selectedTab: Int = 0
    public var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                OnBoardingScreenView(message: "Title Line - 1", paraMessage: "I am the default text and I will be in twooooo lines onlyyyyy", imageName: "Dog-1").tag(0)
                OnBoardingScreenView(message: "Title Line - 2", paraMessage: "I am the default text and I will be in twooooo lines onlyyyyy", imageName: "Dog-2").tag(1)
                OnBoardingScreenView(message: "Title Line - 3", paraMessage: "I am the default text and I will be in twooooo lines onlyyyyy", imageName: "Dog-3").tag(2)
            }
            .padding(.top)
            .padding(.bottom, 30)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationTitle("Fur-tastic to See You!")
            .fontWeight(.light)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MainOnBoardingForm()){
                        Text(selectedTab == 2 ? "Next": "Skip")
                            .foregroundColor(.blue)
                            .font(.headline)
                    }
                }
            }
        }
    }
}
#Preview {
    OnBoardingSwipeView().padding(.horizontal, 10)
}
