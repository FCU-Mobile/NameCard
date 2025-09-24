import SwiftUI

struct NewCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var color: Color = .gray
    
    let existingNames: [String]
    let onSave: (String, Color) -> Void
    
    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private var isDuplicate: Bool {
        let key = trimmedName.lowercased()
        return existingNames
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .contains(key)
    }
    private var canSave: Bool {
        !trimmedName.isEmpty && !isDuplicate
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Category") {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                    ColorPicker("Color", selection: $color, supportsOpacity: false)
                }
                if isDuplicate {
                    Text("This category name already exists.")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(trimmedName, color)
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
}

#Preview {
    NewCategoryView(
        existingNames: ["Clients", "Education"],
        onSave: { _, _ in }
    )
}
