//
//  ContactCategory.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/23.
//

import Foundation
import SwiftData

@Model
class ContactCategory {
    var id: UUID
    var name: String
    var colorHex: String
    var dateCreated: Date

    @Relationship(deleteRule: .nullify, inverse: \StoredContact.category)
    var contacts: [StoredContact] = []

    var contactCount: Int {
        contacts.count
    }

    init(name: String, colorHex: String = "007AFF") {
        self.id = UUID()
        self.name = name
        self.colorHex = colorHex
        self.dateCreated = Date()
    }
}
