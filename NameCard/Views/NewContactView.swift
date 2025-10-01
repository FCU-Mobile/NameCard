import SwiftUI

struct NewContactView: View {
    @Environment(\.dismiss) var dismiss
    // 表單欄位
    @State private var firstName: String
    @State private var lastName: String
    @State private var title: String
    @State private var department: String
    @State private var organization: String
    @State private var address: String
    @State private var email: String
    @State private var phone: String
    @State private var website: String
    @State private var selectedCategory: String
    @State private var selectedType: PersonType
    
    // 編輯模式：若有傳入 existing，則為編輯
    private let existing: Person?
    
    // 分類選單
    let categories: [String]
    // 保存回呼：把新/更新後的 Person 回傳給呼叫端
    let onSave: (Person) -> Void
    
    init(
        existing: Person? = nil,
        categories: [String],
        onSave: @escaping (Person) -> Void
    ) {
        self.existing = existing
        self.categories = categories
        self.onSave = onSave
        
        // 預設值
        let defaultCategory = categories.contains("Uncategorized") ? "Uncategorized" : (categories.first ?? "Uncategorized")
        // 依 existing 帶入初始狀態
        if let person = existing {
            let contact = person.contact
            _firstName = State(initialValue: contact?.firstName ?? person.name.split(separator: " ").first.map(String.init) ?? "")
            _lastName  = State(initialValue: contact?.lastName ?? person.name.split(separator: " ").dropFirst().joined(separator: " "))
            _title     = State(initialValue: contact?.title ?? "")
            _department = State(initialValue: contact?.department ?? "")
            _organization = State(initialValue: contact?.organization ?? "")
            _address   = State(initialValue: contact?.address ?? "")
            _email     = State(initialValue: contact?.email ?? "")
            _phone     = State(initialValue: contact?.phone ?? "")
            _website   = State(initialValue: contact?.website ?? "")
            _selectedCategory = State(initialValue: person.contactCategory ?? defaultCategory)
            _selectedType = State(initialValue: person.type)
        } else {
            _firstName = State(initialValue: "")
            _lastName  = State(initialValue: "")
            _title     = State(initialValue: "")
            _department = State(initialValue: "")
            _organization = State(initialValue: "")
            _address   = State(initialValue: "")
            _email     = State(initialValue: "")
            _phone     = State(initialValue: "")
            _website   = State(initialValue: "")
            _selectedCategory = State(initialValue: defaultCategory)
            _selectedType = State(initialValue: .student)
        }
    }
    
    private var fullName: String {
        let full = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        return full.isEmpty ? "Unnamed" : full
    }
    private var canSave: Bool {
        !(firstName.isEmpty && lastName.isEmpty)
    }
    private var isEditing: Bool { existing != nil }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    Picker("Type", selection: $selectedType) {
                        ForEach(PersonType.allCases, id: \.self) { t in
                            Text(t.rawValue.dropLast()).tag(t)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section(header: Text("Organization")) {
                    TextField("Title", text: $title)
                    TextField("Department", text: $department)
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
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle(isEditing ? "Edit Contact" : "New Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // 組成 Contact 與 Person
                        let contact = Contact(
                            firstName: firstName,
                            lastName: lastName,
                            title: title,
                            organization: organization,
                            email: email,
                            phone: phone,
                            address: address,
                            website: website,
                            department: department
                        )
                        let newPerson = Person(
                            id: existing?.id ?? UUID(), // 編輯時保留原 id
                            name: fullName,
                            type: selectedType,
                            contact: contact,
                            nameCard: existing?.nameCard, // 保留原名片（若有）
                            contactCategory: selectedCategory
                        )
                        onSave(newPerson)
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
}

#Preview {
    NewContactView(
        categories: ["Clients", "Education", "Family", "Friends", "Medical", "Services", "Vendors", "Uncategorized"],
        onSave: { _ in }
    )
}
