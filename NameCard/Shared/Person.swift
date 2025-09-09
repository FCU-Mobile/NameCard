import Foundation

enum PersonType: String, CaseIterable {
    case teacher = "Teachers"
    case student = "Students"
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
        Person(name: "Harry", type: . teacher, contact: Contact.sampleData),
        
        Person(name: "Benjamin", type: .student, contact: Contact(
            firstName: "Yueh",
            middleName: "Benjamin",       // 中間名（你可以改成你想要的）
            lastName: "Chou",
            title: "Computer Science Student",
            organization: "Feng Chia University",
            email: "shuoz4796@gmail.com",
            phone: "+886-988-874-574",
            address: "Taichung, Taiwan",
            website: "https://github.com/YuehBenjamin",
            department: "資訊工程學系"
        ))
    ]
}
