import SwiftUI
import SwiftData

struct PeopleListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ContactPerson.name) private var contactPeople: [ContactPerson]
    
    let people = Person.sampleData
    
    var teachersSorted: [Person] {
        people.filter { $0.type == .teacher }.sorted { $0.name < $1.name }
    }
    
    var studentsSorted: [Person] {
        people.filter { $0.type == .student }.sorted { $0.name < $1.name }
    }
    
    // 按分類分組聯絡人
    var contactsByCategory: [ContactCategory: [ContactPerson]] {
        Dictionary(grouping: contactPeople) { $0.category }
    }
    
    @State private var showingAddContact = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Teachers") {
                    ForEach(teachersSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                
                Section("Students") {
                    ForEach(studentsSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                
                Section {
                    ForEach(ContactCategory.allCases, id: \.self) { category in
                        DisclosureGroup(category.rawValue) {
                            if let categoryContacts = contactsByCategory[category], !categoryContacts.isEmpty {
                                ForEach(categoryContacts.sorted { $0.name < $1.name }) { contactPerson in
                                    NavigationLink(destination: ContactPersonDetailView(contactPerson: contactPerson)) {
                                        ContactPersonRowView(contactPerson: contactPerson)
                                    }
                                }
                                .onDelete { indexSet in
                                    deleteContacts(from: categoryContacts, at: indexSet)
                                }
                            } else {
                                Text("目前沒有聯絡人")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .italic()
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Contact (\(contactPeople.count))")
                        Spacer()
                        Button(action: {
                            showingAddContact = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Directory")
            .sheet(isPresented: $showingAddContact) {
                AddContactView()
            }
            .onAppear {
                print("📱 PeopleListView 載入，目前有 \(contactPeople.count) 個聯絡人")
                for contact in contactPeople {
                    print("   - \(contact.name) (\(contact.category.rawValue))")
                }
            }
        }
    }
    
    private func deleteContacts(from contacts: [ContactPerson], at offsets: IndexSet) {
        let sortedContacts = contacts.sorted { $0.name < $1.name }
        for index in offsets {
            let contactToDelete = sortedContacts[index]
            modelContext.delete(contactToDelete)
            print("🗑️ 刪除聯絡人: \(contactToDelete.name)")
        }
        
        do {
            try modelContext.save()
            print("✅ 成功儲存刪除操作")
        } catch {
            print("❌ 刪除聯絡人時發生錯誤: \(error)")
        }
    }
}

struct PersonRowView: View {
    let person: Person
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                Text(person.type.rawValue.dropLast())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if person.contact != nil {
                Image(systemName: "person.crop.rectangle")
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 2)
    }
}

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        Group {
            if let contact = person.contact {
                // 根據聯絡人姓名顯示對應的名片視圖
                if contact.firstName == "Chris" && contact.lastName == "Yo" {
                    ChrisYoView()
                } else {
                    HarryView(contact: contact)
                }
            } else {
                VStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.gray)
                    Text(person.name)
                        .font(.largeTitle)
                        .padding()
                    Text("No name card available")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactPersonRowView: View {
    let contactPerson: ContactPerson
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(contactPerson.name)
                    .font(.headline)
                Text(contactPerson.category.rawValue)
                    .font(.caption)
                    .foregroundStyle(.blue)
            }
            Spacer()
            if contactPerson.contact != nil {
                Image(systemName: "person.crop.rectangle")
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 2)
    }
}

struct ContactPersonDetailView: View {
    let contactPerson: ContactPerson
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .font(.system(size: 80))
                .foregroundStyle(.gray)
            Text(contactPerson.name)
                .font(.largeTitle)
                .padding()
            Text(contactPerson.category.rawValue)
                .font(.headline)
                .foregroundStyle(.blue)
                .padding(.bottom)
            
            if contactPerson.contact == nil {
                Text("No contact card available")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .navigationTitle(contactPerson.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddContactView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var selectedCategory = ContactCategory.work
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSaving = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("聯絡人資訊") {
                    TextField("姓名", text: $name)
                    
                    Picker("分類", selection: $selectedCategory) {
                        ForEach(ContactCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
            }
            .navigationTitle("新增聯絡人")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                    .disabled(isSaving)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("儲存") {
                        saveContact()
                    }
                    .disabled(name.isEmpty || isSaving)
                }
            }
            .alert("儲存結果", isPresented: $showingAlert) {
                Button("確定") { 
                    if !alertMessage.contains("失敗") {
                        dismiss()
                    }
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func saveContact() {
        isSaving = true
        
        let newContact = ContactPerson(name: name, category: selectedCategory)
        
        // 先插入到 context
        modelContext.insert(newContact)
        
        do {
            // 確保立即儲存
            try modelContext.save()
            
            print("✅ 成功儲存聯絡人: \(name) 到 \(selectedCategory.rawValue)")
            print("📊 ModelContext 狀態: \(modelContext.hasChanges ? "有變更" : "無變更")")
            
            alertMessage = "聯絡人 '\(name)' 已成功儲存到 \(selectedCategory.rawValue) 分類"
            showingAlert = true
            
        } catch {
            print("❌ 儲存聯絡人時發生錯誤: \(error)")
            alertMessage = "儲存失敗: \(error.localizedDescription)"
            showingAlert = true
            
            // 如果儲存失敗，移除剛插入的物件
            modelContext.delete(newContact)
        }
        
        isSaving = false
    }
}

#Preview {
    PeopleListView()
        .modelContainer(for: ContactPerson.self)
}
