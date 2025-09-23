import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var people: [D1397009Person]

    var existingCategories: [String]

    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var selectedCategory = ""
    @State private var isAddingCustomCategory = false
    @State private var customCategory = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Name", text: $name)
                        .autocapitalization(.words)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }

                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(existingCategories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                        Text("➕ New Category").tag("NEW_CATEGORY")
                    }

                    if selectedCategory == "NEW_CATEGORY" {
                        TextField("Enter New Category", text: $customCategory)
                            .autocapitalization(.words)
                    }
                }
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let finalCategory = selectedCategory == "NEW_CATEGORY" ? customCategory : selectedCategory
                        let newPerson = D1397009Person(
                            name: name,
                            phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
                            email: email,
                            category: finalCategory
                        )
                        people.append(newPerson)
                        dismiss()
                    }
                    .disabled(
                        name.isEmpty ||
                        email.isEmpty ||
                        (selectedCategory == "NEW_CATEGORY" ? customCategory.isEmpty : selectedCategory.isEmpty)
                    )
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
