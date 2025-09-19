import SwiftUI

struct NewContactView: View {
    @Environment(\.dismiss) var dismiss
    // 表單欄位
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var title = ""
    @State private var department = ""
    @State private var organization = ""
    @State private var address = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var website = ""
    @State private var selectedCategory: String = "None"
    
    // 分類選單
    let categories: [String]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Title", text: $title)
                    TextField("Department", text: $department)
                }
                Section(header: Text("Organization")) {
                    TextField("Organization", text: $organization)
                    TextField("Address", text: $address)
                }
                Section(header: Text("Contact")) {
                    TextField("Email", text: $email)
                    TextField("Phone", text: $phone)
                    TextField("Website", text: $website)
                }
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        Text("None").tag("None")
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("New Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // 之後可補資料儲存
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewContactView(categories: ["Clients", "Education", "Family", "Friends", "Medical", "Services", "Vendors"])
}
