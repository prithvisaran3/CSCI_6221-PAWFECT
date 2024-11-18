//
//  OnboardingV.swift
//  pawfect_ASP
//
//  Created by Kavya Varshini Anburasu on 10/10/24.
//
import SwiftUI

struct OnboardingV: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    
                    Button(action : {}, label: {
                        Text("Skip")
                            .fontWeight(.semibold)
                            .kerning(1.2)
                        
                    })
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) )
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                Image("Home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 20)
                    .frame(height:300)
                
                Spacer(minLength: screenHeight/5)
                
                Text("Find Your Pup's Perfect Playmate!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(1.5)
                
                Text("Swipe through nearby dogs for meetups and playdates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .kerning(1.2)
                    .padding(.top)
                    .padding(.bottom, 5)
                    .foregroundColor(Color("Color"))
            }
        }
        
    }
}
#Preview {
    OnboardingV()
}
