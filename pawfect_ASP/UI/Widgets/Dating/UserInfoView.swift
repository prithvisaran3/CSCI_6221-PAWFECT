//
//  UserInfoView.swift
//  pawfect_ASP
//
//  Created by Hidhayath Nisha Mohamed Idris on 11/12/24.
//

import SwiftUI
import SwiftData

struct UserInfoView: View {
    @State var dogName : String
    @State var dogBreed: String
    @State var age: Int
    @State var gender: String
    @State var bio: String
    @State var ownerName: String
    init(dogName: String, dogBreed: String, age: Int, gender: String,bio: String,ownerName: String) {
        self.dogName = dogName
        self.dogBreed = dogBreed
        self.age = age
        self.gender = gender
        self.bio = bio
        self.ownerName = ownerName
    }
    var body: some View {
        HStack(alignment: .center, spacing: 10){
            VStack(alignment: .leading) {
                HStack{
                    Text("Owner : \(ownerName)")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .lineLimit(3)
                    Spacer()
                }
                HStack{
                    Text(dogName)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Text( " | " )
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .lineLimit(3)
                    Text(String(age))
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .lineLimit(3)
                }
                HStack{
                    Text(dogBreed)
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .lineLimit(3)
                    Spacer()
                }
                HStack{
                    Text(bio)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .lineLimit(3)
                    Spacer()
                }
                
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 15)
            .frame(width: screenWidth - 100)
            VStack(alignment: .center){
                Image(systemName: gender == "Male" ? "pawprint.circle.fill" : "pawprint.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(gender == "Male" ? .blue : .pink)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 0)
                Text(gender)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(.top, 0)
                    .padding(.bottom, 14)
            }
        }
            .background(
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black,Color.black, Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .offset(y: -50) // Adjust the offset here
                }
                .frame(height: 250) // Set the frame to see the gradient effect

        )

    }
}
#Preview {
    UserInfoView(
        dogName: "Yeontan", dogBreed: "Labrador Retriever", age: 22, gender: "Female",bio: "Hey",ownerName: "Me"
    )
}
