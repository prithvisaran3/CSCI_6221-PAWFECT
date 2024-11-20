import SwiftUI

struct LoginFormView: View {
    @Bindable var authController = AuthController()
    @State private var showSplash: Bool = true // State to control the splash screen visibility

    var body: some View {
        if showSplash {
            SplashScreen(showSplash: $showSplash)
        } else {
            mainLoginFormView
        }
    }

    var mainLoginFormView: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Image("applogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.horizontal, 90)

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
                        .padding(.horizontal, 5)
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
                
                HStack {
                    Spacer()
                    Text("New User?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    NavigationLink(destination: RegistrationFormView()) {
                        Text("Sign Up here")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .bold()
                    }
                    Spacer()
                }
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
}

struct SplashScreen: View {
    @Binding var showSplash: Bool
    @State private var size = 0.8
    @State private var opacity = 0.5

    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image("logo")
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

                Text("Pawfect!") // Change the text to your app name if different
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(primaryColor)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(secondaryColor.ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView()
    }
}
