//
//  AddContactView.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/23.
//

import SwiftUI
import SwiftData

struct AddContactView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var categories: [ContactCategory]

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var title = ""
    @State private var organization = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var website = ""
    @State private var department = ""
    @State private var selectedCategory: ContactCategory?

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Title", text: $title)
                    TextField("Department", text: $department)
                }

                Section("Organization") {
                    TextField("Organization", text: $organization)
                    TextField("Address", text: $address)
                }

                Section("Contact") {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                    TextField("Website", text: $website)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }

                if !categories.isEmpty {
                    Section("Category") {
                        Picker("Category", selection: $selectedCategory) {
                            Text("None").tag(nil as ContactCategory?)
                            ForEach(categories, id: \.id) { category in
                                Text(category.name).tag(category as ContactCategory?)
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveContact()
                    }
                    .disabled(firstName.isEmpty && lastName.isEmpty)
                }
            }
        }
    }

    private func saveContact() {
        let contact = StoredContact(
            firstName: firstName,
            lastName: lastName,
            title: title,
            organization: organization,
            email: email,
            phone: phone,
            address: address,
            website: website,
            department: department,
            category: selectedCategory
        )

        modelContext.insert(contact)
        try? modelContext.save()
        dismiss()
    }
}
