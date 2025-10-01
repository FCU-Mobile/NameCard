//
//  StoredContact.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/16.
//
import SwiftData
import Foundation
@Model
class StoredContact{
    var id: UUID
    var name: String
    var email: String
    
    init(name: String, id: UUID, email: String) {
            self.name = name
            self.id = id
            self.email = email
        }
}
