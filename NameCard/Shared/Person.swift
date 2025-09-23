import Foundation
import SwiftData

enum PersonType: String, CaseIterable {
    case teacher = "Teachers"
    case student = "Students"
}

enum ContactCategory: String, CaseIterable, Codable {
    case work = "Work"
    case family = "Family"
    case company = "Company"
}

@Model
class ContactPerson {
    var id = UUID()
    var name: String
    var category: ContactCategory
    var contact: Contact?
    
    init(name: String, category: ContactCategory, contact: Contact? = nil) {
        self.name = name
        self.category = category
        self.contact = contact
    }
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let type: PersonType
    let contact: Contact?
    
    init(name: String, type: PersonType, contact: Contact? = nil) {
        self.name = name
        self.type = type
        self.contact = contact
    }
}

extension Person {
    static let sampleData: [Person] = [
        Person(name: "Harry", type: .teacher, contact: Contact.sampleData),
        Person(name: "Chris Yo", type: .student, contact: Contact.chrisYoData)
    ]
}

extension ContactPerson {
    static let sampleData: [ContactPerson] = [
        ContactPerson(name: "John Doe", category: .work, contact: nil),
        ContactPerson(name: "Jane Smith", category: .family, contact: nil)
    ]
}
