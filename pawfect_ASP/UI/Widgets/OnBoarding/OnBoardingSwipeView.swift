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
        NavigationView {
            VStack {
                // Show title only on the first screen
                if selectedTab == 0 {
                    Text("Paw-some to Meet You!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("SecondaryColor"))
                        .padding(.top, 20)
                }

                TabView(selection: $selectedTab) {
                    OnBoardingCardView(
                        mainText: "Paw-some to Meet You!",
                        subText: "Your furry friend’s next tail-wagging adventure starts here.",
                        imageName: "Dog-1"
                    )
                    .tag(0)

                    OnBoardingCardView(
                        mainText: "Find Puppy Love!",
                        subText: "Swipe right for the ulti-mutt match.",
                        imageName: "Dog-2"
                    )
                    .tag(1)

                    OnBoardingCardView(
                        mainText: "We Fetch Privacy First!",
                        subText: "Your data is protected—no bones about it!",
                        imageName: "Dog-3"
                    )
                    .tag(2)
                }
                .background(Color("SecondaryColor"))
                .padding(.top)
                .padding(.bottom, 30)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                // Navigation button
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: MainOnBoardingForm()) {
                            Text(selectedTab == 2 ? "Next" : "Skip")
                                .foregroundColor(Color("PrimaryColor"))
                                .font(.headline)
                        }
                    }
                }
            }
            .background(Color("SecondayColor"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OnBoardingSwipeView().padding(.horizontal, 10).background(Color("SecondaryColor"), ignoresSafeAreaEdges: .all)
}
