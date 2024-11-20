import SwiftUI
import Supabase

@MainActor
class HomeController: ObservableObject {
    @Published var petProfiles: [PetProfile] = []  // Holds all fetched pet profiles
    @Published var isLoading = false               // Indicates if the data is being loaded

    // Fetch all available pet profiles except the current user's profile
    func fetchAllPets() async {
        isLoading = true
        do {
            // Getting the current session and user
            let session = try await supabase.auth.session

            // Fetch all profiles except the current user's profile
            let response = try await supabase
                .from("users")
                .select("*")  // Select all fields
                .neq("id", value: session.user.id)  // Exclude the current user from the results
                .execute()

            // Extract and decode the data into PetProfile objects
            let petProfiles = try JSONDecoder().decode([PetProfile].self, from: response.data)

            DispatchQueue.main.async {
                self.petProfiles = petProfiles
            }

        } catch {
            debugPrint("Error fetching pet profiles: \(error)")
        }
        isLoading = false
    }

    // Function to handle swipe action (left or right)
    func handleSwipe(currentUserId: UUID, swipedUserId: UUID, direction: String) async {
        do {
            // Create a swipe entry for the current user
            let swipeData = SwipeEntry(user_id: currentUserId.uuidString, swiped_user_id: swipedUserId.uuidString, direction: direction)
            
            // Insert the swipe data into the 'swipes' table
            try await supabase
                .from("swipes")
                .insert([swipeData])
                .execute()

            // If the swipe is right, check if it's a match
            if direction == "right" {
                await checkMatch(currentUserId: currentUserId, swipedUserId: swipedUserId)
            }

        } catch {
            debugPrint("Error handling swipe: \(error)")
        }
    }

    // Function to check if there is a match (mutual right swipe)
    private func checkMatch(currentUserId: UUID, swipedUserId: UUID) async {
        do {
            // Query the 'swipes' table to see if the swiped user also swiped right on the current user
            let matchQuery = try await supabase
                .from("swipes")
                .select("*")
                .eq("user_id", value: swipedUserId.uuidString)
                .eq("swiped_user_id", value: currentUserId.uuidString)
                .eq("direction", value: "right")
                .execute()

            // Extract data to determine if there's a match
            let matchData = matchQuery.data

            // Decode the response into an array of SwipeEntry objects
            let matches = try JSONDecoder().decode([SwipeEntry].self, from: matchData)

            // If a match is found, create a match entry
            if !matches.isEmpty {
                await createMatch(user1Id: currentUserId, user2Id: swipedUserId)
            }

        } catch {
            debugPrint("Error checking for match: \(error)")
        }
    }

    // Function to create a match between two users
    private func createMatch(user1Id: UUID, user2Id: UUID) async {
        do {
            // Create match entry between the two users
            let matchData = MatchEntry(user1_id: user1Id.uuidString, user2_id: user2Id.uuidString)
            try await supabase
                .from("matches")
                .insert([matchData])
                .execute()

            debugPrint("Match created successfully between \(user1Id) and \(user2Id)")
        } catch {
            debugPrint("Error creating match: \(error)")
        }
    }
}

// PetProfile struct representing each user's pet profile
struct PetProfile: Codable, Identifiable {
    var id: String
    var dogName: String?
    var dogBreed: String?
    var dogAge: String?
    var dogGender: String?
    var ownerName: String?
    var petBio: String?
    var avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, dogName = "dog_name", dogBreed = "dog_breed", dogAge = "dog_age", dogGender = "dog_gender", ownerName = "owner_name", petBio = "dog_bio", avatarURL = "avatar_url"
    }
}

// SwipeEntry struct representing a swipe action
struct SwipeEntry: Codable {
    var user_id: String
    var swiped_user_id: String
    var direction: String
}

// MatchEntry struct representing a match between two users
struct MatchEntry: Encodable {
    var user1_id: String
    var user2_id: String
}
