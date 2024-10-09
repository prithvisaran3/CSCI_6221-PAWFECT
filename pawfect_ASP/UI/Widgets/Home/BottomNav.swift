//
//  BottomNav.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 10/8/24.
//

import SwiftUI

struct BottomNav: View {
    var body: some View {
        TabView{
            Text("Shop Screen")
                .tabItem{ Image(systemName: "bag")}
                .tag(0)
            Text("PetDate Screen")
                .tabItem{ Image(systemName: "heart")}
                .tag(1)
            Text("Stylist Screen")
                .tabItem{ Image(systemName: "comb")}
                .tag(2)
            Text("Profile Screen")
                .tabItem{ Image(systemName: "person")}
                .tag(3)
        }
        .tint(.primary)
    }
}

#Preview {
    BottomNav()
}
