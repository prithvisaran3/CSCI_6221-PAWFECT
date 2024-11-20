import SwiftUI

struct AppView: View {
    var body: some View {
        NavigationContainerView()
    }
}

struct NavigationContainerView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Screen
            NavigationView {
                DatingMainScreenView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(Tab.home)

            // Chat List Screen
            NavigationView {
                ChatListView()
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Match")
            }
            .tag(Tab.chats)
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(Tab.profile)
        }
        .accentColor(Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)) // Matches primaryColor
    }
}

enum Tab {
    case home, chats, profile
}

// Ensure you already have these screens implemented:
// DatingMainScreenView
// ChatListView

// Placeholder Preview
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
