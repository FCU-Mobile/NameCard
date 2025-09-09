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
    let middleName: String? // 新增中間名屬性
    let title: String
    let organization: String
    let email: String
    let phone: String
    let address: String
    let website: String
    let department: String

    var fullName: String {
        if let middleName = middleName, !middleName.isEmpty {
            return "\(firstName) \(middleName) \(lastName)"
        } else {
            return "\(firstName) \(lastName)"
        }
    }

    var displayName: String {
        fullName.uppercased()
    }
    
    // 為了向下相容，提供不含中間名的初始化器
    init(firstName: String, lastName: String, title: String, organization: String, email: String, phone: String, address: String, website: String, department: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = nil
        self.title = title
        self.organization = organization
        self.email = email
        self.phone = phone
        self.address = address
        self.website = website
        self.department = department
    }
    
    // 包含中間名的初始化器
    init(firstName: String, middleName: String?, lastName: String, title: String, organization: String, email: String, phone: String, address: String, website: String, department: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.title = title
        self.organization = organization
        self.email = email
        self.phone = phone
        self.address = address
        self.website = website
        self.department = department
    }

    func toVCard() -> String {
        let fullNameForVCard = middleName != nil ? "\(firstName) \(middleName!) \(lastName)" : "\(firstName) \(lastName)"
        return """
        BEGIN:VCARD
        VERSION:3.0
        FN:\(fullNameForVCard)
        N:\(lastName);\(firstName);\(middleName ?? "");;
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
}
