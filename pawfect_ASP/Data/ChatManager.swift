import Foundation

@MainActor
class ChatManager: ObservableObject {
    static let shared = ChatManager() // Singleton instance
    
    @Published var matchedProfiles: [PetProfile] = [] // Stores matched profiles
    
    private init() {}
    
    func addMatch(profile: PetProfile) {
        if !matchedProfiles.contains(where: { $0.id == profile.id }) {
            matchedProfiles.append(profile)
        }
    }
}
