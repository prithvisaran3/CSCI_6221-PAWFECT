import SwiftUI
import PhotosUI
import UIKit

struct ImagePicker: View {
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            Text("Select an Image")
                .font(.headline)
                .padding()
            
            Button("Choose from Library") {
                // Image picking logic goes here (using UIImagePickerController or a library like PhotosUI)
            }
            .padding()
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }
        }
    }
}
