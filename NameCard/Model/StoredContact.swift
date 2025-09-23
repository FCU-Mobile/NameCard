//
//  StoredContact.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/23.
//

import Foundation
import SwiftData

@Model
class StoredContact {
    var id: UUID
    var firstName: String
    var lastName: String
    var title: String
    var organization: String
    var email: String
    var phone: String
    var address: String
    var website: String
    var department: String
    var dateAdded: Date

    var category: ContactCategory?

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    var displayName: String {
        fullName.uppercased()
    }

    init(
        firstName: String,
        lastName: String,
        title: String = "",
        organization: String = "",
        email: String = "",
        phone: String = "",
        address: String = "",
        website: String = "",
        department: String = "",
        category: ContactCategory? = nil
    ) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
        self.organization = organization
        self.email = email
        self.phone = phone
        self.address = address
        self.website = website
        self.department = department
        self.dateAdded = Date()
        self.category = category
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
