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
    
    static let meiwataData = Contact(
            firstName: "卿如",
            lastName: "廖",
            title: "學生",
            organization: "逢甲大學",
            email: "LL@o365.fcu.edu.tw",
            phone: "0988-123-456",
            address: "台中市西屯區文華路100號",
            website: "https://www.fcu.edu.tw/",
            department: "資訊工程學系"
        )
}
