//
//  Contact.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import Foundation
import SwiftData

@Model
class Contact {
    var firstName: String
    var lastName: String
    var title: String
    var organization: String
    var email: String
    var phone: String
    var address: String
    var website: String
    var department: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    var displayName: String {
        fullName.uppercased()
    }
    
    init(firstName: String, lastName: String, title: String, organization: String, email: String, phone: String, address: String, website: String, department: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
        self.organization = organization
        self.email = email
        self.phone = phone
        self.address = address
        self.website = website
        self.department = department
    }

    func toVCard() -> String {
        return """
        BEGIN:VCARD
        VERSION:3.0
        FN:\(fullName)
        N:\(lastName);\(firstName);;;
        ORG:\(organization)
        TITLE:\(title)
        EMAIL:\(email)
        TEL:\(phone)
        ADR:;;\(address);;;
        URL:\(website)
        NOTE:\(department)
        END:VCARD
        """
    }
}

extension Contact {
    static let sampleData = Contact(
        firstName: "Harry",
        lastName: "Ng",
        title: "iOS Developer",
        organization: "Feng Chia University",
        email: "contact@buildwithharry.com",
        phone: "+886-909-007-162",
        address: "Taichung, Taiwan",
        website: "buildwithharry.com",
        department: "AI Coding"
    )
    
    static let chrisYoData = Contact(
        firstName: "Chris",
        lastName: "Yo",
        title: "Software Engineer",
        organization: "Feng Chia University",
        email: "D1397129@fcu.edu.tw",
        phone: "04-2451-7250",
        address: "Taichung, Taiwan",
        website: "https://www.fcu.edu.tw/",
        department: "Computer Science"
    )
}
