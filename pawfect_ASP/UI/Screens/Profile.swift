//
//  Profile.swift
//  pawfect_ASP
//
//  Created by Kavya Varshini Anburasu on 12/11/24.
//
import SwiftUI

struct ProfileView: View {
    @Bindable var profileController = ProfileController()
    
    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)
    
    

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                // Header
                HStack {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(primaryColor)
                    
                    Spacer()
                    
                    Text("Profile")
                        .font(.system(size: 24, weight: .bold))
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(primaryColor)
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
                            Text("Hi, \(profileController.username)")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text("user_id")
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
                        petName: "Charlie",
                        petBreed: "American Pit Bull Terrier",
                        petAge: "2 years",
                        petGender: "Male",
                        petDescription: """
                        Charlie  loves to play fetch, go on long walks, and spend time with his family. Charlie has a gentle personality and is great with kids, making him a perfect companion.
                        """
                    )) {
                        PetCardView(petName: "Charlie", petBreed: "American Pit Bull Terrier", backgroundColor: primaryColor)
                            .frame(width: 250, height: 300)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                
                // Breed Facts Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Breed Facts")
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            FactCardView(fact: "Pit Bulls are known for their strength and loyalty.")
                            FactCardView(fact: "They are very friendly and affectionate with family.")
                            FactCardView(fact: "Regular exercise is essential for this breed.")
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .background(secondaryColor.ignoresSafeArea())
            .navigationBarHidden(true)
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

    let primaryColor = Color(red: 155 / 255, green: 39 / 255, blue: 90 / 255)
    let secondaryColor = Color(red: 254 / 255, green: 211 / 255, blue: 231 / 255)

    let petImages: [String] = ["dog1", "dog2", "dog3", "dog4"] // Replace with actual image names

    var body: some View {
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
