//
//  ContactCategory.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/16.
//
import SwiftData
import Foundation

class ContactCategory{
    var name: String
    var id: UUID
    init(var name: String, var id: UUID){
        self.name = name
        self.id = id
    }
}
