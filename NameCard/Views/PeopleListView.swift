import SwiftUI

struct PeopleListView: View {
    let people = Person.sampleData
    
    // Add menu states
    @State private var showAddMenu = false
    @State private var showNewContactSheet = false
    @State private var showNewGroupSheet = false
    
    // Sample 分組資料（可改為你的實際資料來源）
    private let contactGroups: [ContactGroup] = [
        .init(name: "Education", count: 1, color: .purple),
        .init(name: "Family", count: 3, color: .red),
        .init(name: "Friends", count: 3, color: .green),
        .init(name: "Medical", count: 2, color: .pink),
        .init(name: "Services", count: 1, color: .teal),
        .init(name: "Vendors", count: 1, color: .indigo),
        .init(name: "Work", count: 3, color: .blue),
        .init(name: "Uncategorized", count: 5, color: .gray)
    ]
    
    var teachersSorted: [Person] {
        people.filter { $0.type == .teacher }.sorted { $0.name < $1.name }
    }
    
    var studentsSorted: [Person] {
        people.filter { $0.type == .student }.sorted { $0.name < $1.name }
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Teachers
                Section("Teachers") {
                    ForEach(teachersSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                
                // Students（依 sampleData 顯示）
                Section("Students") {
                    ForEach(studentsSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                
                // Contacts（自訂 header，右側帶 + 按鈕）
                Section {
                    ForEach(contactGroups) { group in
                        NavigationLink {
                            ContactGroupDetailView(group: group)
                        } label: {
                            ContactGroupRow(group: group)
                        }
                    }
                } header: {
                    HStack {
                        Text("Contacts")
                        Spacer()
                        // 以 Button 觸發 confirmationDialog，呈現兩個選項
                        Button {
                            showAddMenu = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.blue)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Add Contact or Group")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Directory")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: 放你的統計/儀表板動作
                    } label: {
                        Image(systemName: "chart.bar.xaxis")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.blue)
                            .padding(10)
                            .background(.thinMaterial, in: Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Dashboard")
                }
            }
            // 選單：新增聯絡人 / 新增群組
            .confirmationDialog("新增", isPresented: $showAddMenu, titleVisibility: .visible) {
                Button {
                    showNewContactSheet = true
                } label: {
                    Label("新增聯絡人", systemImage: "person.crop.circle.badge.plus")
                }
                
                Button {
                    showNewGroupSheet = true
                } label: {
                    Label("新增群組", systemImage: "folder.badge.plus")
                }
                
                Button("取消", role: .cancel) {}
            }
            // 兩個示範用 Sheet（之後可替換成實際表單）
            .sheet(isPresented: $showNewContactSheet) {
                NewContactSheet()
            }
            .sheet(isPresented: $showNewGroupSheet) {
                NewGroupSheet()
            }
        }
    }
}

// MARK: - Row: Person
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

// MARK: - Detail Router
struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        Group {
            if let contact = person.contact {
                // Route to appropriate name card view based on person's name
                switch person.name.lowercased() {
                case "harry":
                    HarryView(contact: contact)
                case "roger":
                    RogerView(contact: contact)
                case "zoe":
                    ZoeView(contact: contact)
                default:
                    if let nameCard = person.nameCard {
                        AnyView(erasing: nameCard)
                    } else {
                        HarryView(contact: contact) // Default fallback
                    }
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

// MARK: - Contacts Group Row
private struct ContactGroupRow: View {
    let group: ContactGroup
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(group.color)
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(group.name)
                    .font(.headline)
                Text("\(group.count) contact\(group.count == 1 ? "" : "s")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Contacts Group Detail (Placeholder)
private struct ContactGroupDetailView: View {
    let group: ContactGroup
    var body: some View {
        Text("\(group.name) – \(group.count) contact\(group.count == 1 ? "" : "s")")
            .navigationTitle(group.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Model for Contacts section
private struct ContactGroup: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
    let color: Color
}

// MARK: - Placeholder Sheets
private struct NewContactSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("基本資料") {
                    TextField("姓名", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("電話", text: $phone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("新增聯絡人")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("儲存") {
                        // TODO: 實作儲存
                        dismiss()
                    }
                }
            }
        }
    }
}

private struct NewGroupSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var groupName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("群組名稱") {
                    TextField("例如：Family", text: $groupName)
                }
            }
            .navigationTitle("新增群組")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("建立") {
                        // TODO: 實作新增群組
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    PeopleListView()
}
