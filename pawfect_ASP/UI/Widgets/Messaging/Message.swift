import Foundation
import UIKit
struct Message: Identifiable {
    let id = UUID()
    let content: String? // Text message content
    let image: UIImage?  // Image to display
    let isSentByUser: Bool
    
    init(content: String? = nil, image: UIImage? = nil, isSentByUser: Bool) {
        self.content = content
        self.image = image
        self.isSentByUser = isSentByUser
    }
}
