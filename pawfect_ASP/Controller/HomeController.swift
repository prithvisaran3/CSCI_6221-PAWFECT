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
                .from("profiles")
                .select()
                .neq("id", value: currentUser.id)
                .execute()
                .value
            
            debugPrint("Response is \(response)")

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
        case id, dogName, dogBreed, dogAge, dogGender, ownerName, petBio, avatarURL
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        dogName = try container.decodeIfPresent(String.self, forKey: .dogName) ?? "Unknown"
        dogBreed = try container.decodeIfPresent(String.self, forKey: .dogBreed) ?? "Unknown Breed"
        dogAge = try container.decodeIfPresent(String.self, forKey: .dogAge) ?? "Unknown Age"
        dogGender = try container.decodeIfPresent(String.self, forKey: .dogGender) ?? "Unknown Gender"
        ownerName = try container.decodeIfPresent(String.self, forKey: .ownerName) ?? "Unknown Owner"
        petBio = try container.decodeIfPresent(String.self, forKey: .petBio) ?? "No Bio"
        avatarURL = try container.decodeIfPresent(String.self, forKey: .avatarURL)
    }
}
