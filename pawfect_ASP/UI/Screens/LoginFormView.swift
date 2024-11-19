import SwiftUI

struct LoginFormView: View {
    @Bindable var authController = AuthController()
    @State private var userEmail = ""
    @State private var userPassword = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Text("Hey There!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(
                        ZStack {
                            Color.clear
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white.opacity(0.6), Color.white.opacity(0)]),
                                startPoint: .top,
                                endPoint: .center
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.horizontal, -10)
                            .padding(.vertical, -5)
                        }
                    )
                Spacer()
            }
            
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "envelope")
                    .foregroundColor(Color("PrimaryColor"))
                TextField("Enter your email", text: $authController.userEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }
            
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "key")
                    .foregroundColor(Color("PrimaryColor"))
                SecureField("Enter your password", text: $authController.userPassword)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
            }
            
            Button(action: {
                Task {
                    await authController.login()
                }
            }) {
                if authController.isLoading {
                    ProgressView()
                        .frame(width: 75, height: 75)
                        .tint(.white)
                } else {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(
                            ZStack {
                                Color("PrimaryColor")
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.1)]),
                                    startPoint: .top,
                                    endPoint: .center
                                )
                                .cornerRadius(10)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .blendMode(.overlay)
                            }
                        )
                        .cornerRadius(10)
                }
            }
            .padding(.top, 20)
            .disabled(authController.userEmail.isEmpty || authController.userPassword.isEmpty)
        }
        .padding()
        .alert(isPresented: $authController.showAlert, content: {
            Alert(
                title: Text("Error"),
                message: Text(authController.errorMessage ?? "Unknown Error"),
                dismissButton: .default(Text("Try Again"))
            )
        })
    }
}

#Preview {
    LoginFormView()
}
