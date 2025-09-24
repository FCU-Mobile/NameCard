//
//  ContactCategory.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/16.
//
import Foundation
import SwiftUI
import SwiftData

@Model
class ContactCategory{
    var id: UUID
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \StoredContact.category)
    var contacts:[StoredContact] = []
   
    
    init(id: UUID, name:String){
        self.id = id
        self.name = name
    }
}


//#Preview {
//    ContactCategory()
//}
