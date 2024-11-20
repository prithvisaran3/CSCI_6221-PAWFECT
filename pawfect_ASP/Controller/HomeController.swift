import SwiftUI
import Supabase

@MainActor
class HomeController: ObservableObject {
    @Published var petProfiles: [PetProfile] = []  // Holds all fetched pet profiles
    @Published var isLoading = false               // Indicates if the data is being loaded

    func fetchAllPets() async {
        isLoading = true
        do {
            let currentUser = try await supabase.auth.session.user
            let response: [PetProfile] = try await supabase
                .from("users")
                .select()
                .neq("id", value: currentUser.id)
                .execute()
                .value

            DispatchQueue.main.async {
                self.petProfiles = response
            }
        } catch {
            debugPrint("Error fetching pet profiles: \(error)")
        }
        isLoading = false
    }
}

struct PetProfile: Codable, Identifiable {
    var id: String
    var dogName: String?       // Make properties optional
    var dogBreed: String?
    var dogAge: String?
    var dogGender: String?
    var ownerName: String?
    var petBio: String?
    var avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, dogName = "dog_name", dogBreed = "dog_breed", dogAge = "dog_age", dogGender = "dog_gender", ownerName = "owner_name", petBio = "dog_bio", avatarURL = "dog_pic1"
    }
}
