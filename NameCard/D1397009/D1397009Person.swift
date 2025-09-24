import Foundation

struct D1397009Person: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var phoneNumber: String?
    var email: String
    var category: String  // e.g., "Education", "Family", etc.
}
