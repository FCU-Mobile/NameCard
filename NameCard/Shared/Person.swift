import Foundation
import SwiftUI

enum PersonType: String, CaseIterable {
    case teacher = "Teachers"
    case student = "Students"
}

struct Person: Identifiable {
    let id: UUID
    let name: String
    let type: PersonType
    let contact: Contact?
    let nameCard: (any View)?
    let contactCategory: String? // 新增聯絡人分類屬性
    
    init(
        id: UUID = UUID(),
        name: String,
        type: PersonType,
        contact: Contact? = nil,
        nameCard: (any View)? = nil,
        contactCategory: String? = nil
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.contact = contact
        self.nameCard = nameCard
        self.contactCategory = contactCategory
    }
}

extension Person {
    static let sampleData: [Person] = [
        Person(name: "Harry", type: .teacher, contact: Contact.sampleData, contactCategory: "Clients"),
        Person(name: "Zoe", type: .student, contact: Contact.zoeStudent, contactCategory: "Education"),
        Person(name: "Fw", type: .student, contact: Contact.FwStudent, contactCategory: "Education"),
        Person(name: "Leo", type: .student, contact: LeoView.contact, nameCard: LeoView(), contactCategory: "Friends"),
        Person(name: "Roger", type: .student, contact: Contact.rogerSampleData, contactCategory: "Services")
    ]
}
