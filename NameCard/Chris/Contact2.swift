//
//  Contact2.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/9.
//
import Foundation

struct Contact2 {
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

extension Contact2 {
    static let sampleData = Contact(
        firstName: "Chris",
        lastName: "Chou",
        title: "Writer Who Uses Front-End To Create Articles",
        organization: "Feng Chia University",
        email: "chou.yenting@gmail.com",
        phone: "+886-977-203-867",
        address: "Taichung, Taiwan",
        website: "https://www.facebook.com/chris.chou.776839",
        department: "AI Coding"
    )
}
