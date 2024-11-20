//
//  Profile.swift
//  pawfect_ASP
//
//  Created by Kavya Varshini Anburasu on 12/11/24.
//
import SwiftUI

struct ProfileView: View {
    @Bindable var profileController = ProfileController()
    @StateObject var homeController = HomeController()
    @Bindable var authController  = AuthController()
    
    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                // Header
                HStack {
                   
                    
                    Text("Profile")
                        .font(.system(size: 24, weight: .bold))
                    
                    
                }
                .padding(.horizontal)
                
                // Centered Profile Header
                HStack {
                    Spacer()

                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Hi, \(profileController.ownerName)")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text("\(profileController.id)")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Centered "Your Pet" Title and Card
                VStack(spacing: 8) {
                    Text("Your Pet")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 5)

                    NavigationLink(destination: PetDetailView(
                        petName: profileController.dogName,
                        petBreed: profileController.dogBreed,
                        petAge: profileController.dogAge,
                        petGender: profileController.dogGender,
                        petDescription: profileController.dogBio,
                        dog1: profileController.dog_pic1,
                        dog2: profileController.dog_pic2,
                        dog3: profileController.dog_pic3,
                        dog4: profileController.dog_pic4
                        
                    )) {
                        PetCardView(petName: profileController.dogName, petBreed: profileController.dogBreed, backgroundColor: primaryColor)
                            .frame(width: 250, height: 300)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                
                // Breed Facts Section
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack {
//                        Text("Breed Facts")
//                            .font(.system(size: 18, weight: .semibold))
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 15) {
//                            FactCardView(fact: "Pit Bulls are known for their strength and loyalty.")
//                            FactCardView(fact: "They are very friendly and affectionate with family.")
//                            FactCardView(fact: "Regular exercise is essential for this breed.")
//                        }
//                        .padding(.horizontal)
//                    }
//                }
                Button(action: {
                    Task {
                        await authController.logout()
                        // Handle navigation to the login view here
//                        await homeController.fetchAllPets()
                    }
                }) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(primaryColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)

                Spacer()
            }
            .background(secondaryColor.opacity(0.5).ignoresSafeArea())
            .navigationBarHidden(true)
            .onAppear {
                Task {
                    await profileController.getInitialProfile()
//                    await authController.logout()
                }
            }
        }
    }
}

struct PetCardView: View {
    var petName: String
    var petBreed: String
    var backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "pawprint.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
            
            Text(petName)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            
            Text(petBreed)
                .font(.system(size: 16))
                .foregroundColor(Color.white.opacity(0.8))
        }
        .frame(width: 250, height: 250)
        .background(backgroundColor)
        .cornerRadius(20)
    }
}

struct FactCardView: View {
    var fact: String
    
    var body: some View {
        Text(fact)
            .font(.system(size: 16))
            .padding()
            .frame(width: 220, height: 120)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

struct PetDetailView: View {
    var petName: String
    var petBreed: String
    var petAge: String
    var petGender: String
    var petDescription: String
    var dog1: String
    var dog2: String
    var dog3: String
    var dog4: String
    

    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    var petImages: [String]

        init(petName: String, petBreed: String, petAge: String, petGender: String, petDescription: String, dog1: String, dog2: String, dog3: String, dog4: String) {
            self.petName = petName
            self.petBreed = petBreed
            self.petAge = petAge
            self.petGender = petGender
            self.petDescription = petDescription
            self.dog1 = dog1
            self.dog2 = dog2
            self.dog3 = dog3
            self.dog4 = dog4
            self.petImages = [dog1, dog2, dog3, dog4]
        }


    var body: some View {
        ScrollView{
        VStack(spacing: 20) {
            // Pet's Name
            Text(petName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(primaryColor)
                .padding(.top, 20)
            
            // Animated Pet Sticker
            AnimatedPetSticker()
                .frame(width: 150, height: 150)
            
            // Pet Details Section
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Breed:")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    Spacer()
                    Text(petBreed)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                
                HStack {
                    Text("Age:")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    Spacer()
                    Text(petAge)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Gender:")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                    Spacer()
                    Text(petGender)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // "Your Pet's Pictures" Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Your Pet's Pictures")
                    .font(.headline)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(petImages.prefix(4), id: \.self) { imageName in
                            if let image = UIImage(named: imageName) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 5)
                            } else {
                                Color.gray
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .overlay(
                                        Text("No Image")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.top, 10)
            
            // "About the Pet" Section
            VStack(alignment: .leading, spacing: 10) {
                Text("About \(petName)")
                    .font(.headline)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal, 20)
                
                Text(petDescription)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal, 20)
            }
            .padding(.top, 10)
            
            Spacer()
        }
    }
        .background(secondaryColor.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Pet Details")
    }
}

// Animated Pet Sticker
struct AnimatedPetSticker: View {
    @State private var isAnimating = false

    var body: some View {
        Image(systemName: "pawprint")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.pink)
            .scaleEffect(isAnimating ? 1.1 : 1.0)
            .animation(
                Animation.easeInOut(duration: 1.0)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
