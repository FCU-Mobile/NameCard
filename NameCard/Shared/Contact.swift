//
//  Contact.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import Foundation

struct Contact {
    let firstName: String
    let lastName: String
    let title: String
    let organization: String
    let email: String
    let phone: String
    let address: String
    let website: String
    let department: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    var displayName: String {
        fullName.uppercased()
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
    
    static let ashtonData = Contact(
        firstName: "Ashton",
        lastName: "Owl",
        title: "iOS Developer",
        organization: "Feng Chia University",
        email: "contact@buildwithashton.com",
        phone: "+886-909-007-162",
        address: "Taichung, Taiwan",
        website: "buildwithashton.com",
        department: "AI Coding"
      
    static let rogerSampleData = Contact(
        firstName: "Roger",
        lastName: "Chen",
        title: "Senior Smooth Replies Manager",
        organization: "ChatGPT University",
        email: "roger@liftwithroger.com",
        phone: "+1-555-123-4567",
        address: "San Francisco, CA",
        website: "elkmr-code.github.io/Tutoring-Resume",
        department: "Mom's Basement"

    )
}
