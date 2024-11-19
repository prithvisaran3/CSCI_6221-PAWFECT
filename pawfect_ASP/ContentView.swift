import SwiftUI
struct ContentView: View {

    @State private var isAuthenticated=false
    var body: some View {
        Group {
            if isAuthenticated {
                VStack {
                    Text("Hello, World!")

                }
                .padding()
            }else{
                LoginFormView()
            }
            }

        .task {
            for await state in supabase.auth.authStateChanges{
                if [.initialSession,.signedIn,.signedOut].contains(state.event){
                    isAuthenticated = state.session != nil
                }

            }
        }
        
    }
}
#Preview {
    ContentView()
}
