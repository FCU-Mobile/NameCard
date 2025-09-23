import SwiftUI

struct AddCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var categories: [String]

    @State private var newCategory = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Category")) {
                    TextField("Enter category name", text: $newCategory)
                        .autocapitalization(.words)
                }
            }
            .navigationTitle("Add Category")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmed = newCategory.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty && !categories.contains(trimmed) {
                            categories.append(trimmed)
                        }
                        dismiss()
                    }
                    .disabled(newCategory.trimmingCharacters(in: .whitespaces).isEmpty)
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
