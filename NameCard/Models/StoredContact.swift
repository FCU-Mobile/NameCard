//
//  StoreContact.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/16.
//

import SwiftUI
import Foundation
import SwiftData

@Model
class StoredContact{
    var id: UUID
    var name: String
    var title: String
    var email: String
    
//    @Relationship(inverse: \ContactCategory.contacts)
    var category: ContactCategory?
    
    init(id: UUID,name: String,title: String,email: String){
        self.id = id
        self.name = name
        self.title = title
        self.email = email
        
    }
}

//#Preview {
//    StoreContact()
//}
