import Foundation

struct Exercise: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var muscleGroups: [String]
    var image: String
    var hkType: String
}
