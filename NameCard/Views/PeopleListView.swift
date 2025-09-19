import SwiftUI

// 主要聯絡人列表頁面
struct PeopleListView: View {
    // 假資料來源，實際應用可改為資料庫或 API
    let people = Person.sampleData
    
    // 聯絡人分類顏色對應表
    let categoryColors: [String: Color] = [
        "Clients": .red,
        "Education": .blue,
        "Family": .orange,
        "Friends": .green,
        "Medical": .pink,
        "Services": .purple,
        "Vendors": .gray
    ]
    
    // 動態產生分類陣列，並計算每個分類下有多少聯絡人
    var contactsCategories: [ContactCategoryUI] {
        let categories = people.compactMap { $0.contactCategory }
        let unique = Set(categories)
        var result: [ContactCategoryUI] = []
        for name in categoryColors.keys.sorted() {
            let count = categories.filter { $0 == name }.count
            result.append(ContactCategoryUI(name: name, color: categoryColors[name] ?? .gray, count: count))
        }
        return result
    }
    
    // 依照 type 過濾並排序老師
    var teachersSorted: [Person] {
        people.filter { $0.type == .teacher }.sorted { $0.name < $1.name }
    }
    
    // 依照 type 過濾並排序學生
    var studentsSorted: [Person] {
        people.filter { $0.type == .student }.sorted { $0.name < $1.name }
    }
    
    // 控制顯示新增/刪除聯絡人分類的選單
    @State private var showContactMenu = false
    // 控制顯示新增聯絡人表單
    @State private var showAddContactSheet = false
    // 控制顯示新增分類的提示
    @State private var showAddCategoryAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                // 老師區塊
                Section("Teachers") {
                    ForEach(teachersSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                
                // 學生區塊
                Section("Students") {
                    ForEach(studentsSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                // 聯絡人分類區塊，header 右側有＋按鈕
                Section(header:
                    HStack {
                        Text("Contacts")
                            .font(.headline)
                        Spacer()
                        Button(action: { showContactMenu = true }) {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                        }
                        .accessibilityLabel("Add or Delete Contact Category")
                    }
                ) {
                    ForEach(contactsCategories) { category in
                        NavigationLink(destination: ContactsListView(categoryName: category.name, people: people)) {
                            ContactCategoryRowView(category: category)
                        }
                    }
                }
            }
            .navigationTitle("Directory")
            // 彈出操作選單
            .confirmationDialog("選擇操作", isPresented: $showContactMenu, titleVisibility: .visible) {
                Button {
                    showAddContactSheet = true
                } label: {
                    Label("Add Contact", systemImage: "person.badge.plus")
                }
                Button {
                    showAddCategoryAlert = true
                } label: {
                    Label("Add Category", systemImage: "folder.badge.plus")
                }
                Button("取消", role: .cancel) { }
            }
            // 新增聯絡人表單
            .sheet(isPresented: $showAddContactSheet) {
                NewContactView(categories: categoryColors.keys.sorted())
            }
            // 新增分類提示
            .alert("新增分類功能尚未實作", isPresented: $showAddCategoryAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

// 顯示特定分類下所有聯絡人的列表
struct ContactsListView: View{
    let categoryName: String
    let people: [Person]
    // 過濾出屬於該分類的聯絡人
    var filteredPeople: [Person] {
        people.filter { $0.contactCategory == categoryName }
    }
    var body: some View {
        List(filteredPeople) { person in
            NavigationLink(destination: PersonDetailView(person: person)) {
                PersonRowView(person: person)
            }
        }
        .navigationTitle(categoryName)
    }
}
    
    
// 單一聯絡人列表列元件
struct PersonRowView: View {
    let person: Person
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                // 顯示身分類型
                Text(person.type.rawValue.dropLast())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            // 若有聯絡資訊則顯示圖示
            if person.contact != nil {
                Image(systemName: "person.crop.rectangle")
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 2)
    }
}

// 聯絡人詳細頁面，根據姓名顯示不同名片
struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        Group {
            if let contact = person.contact {
                // 根據姓名顯示對應名片畫面
                switch person.name.lowercased() {
                case "harry":
                    HarryView(contact: contact)
                case "roger":
                    RogerView(contact: contact)
                case "zoe":
                    ZoeView(contact: contact)
                case "fw":
                    FwView(contact: contact)
                
                    
                default:
                    if let nameCard = person.nameCard {
                        AnyView(nameCard)
                    } else {
                        HarryView(contact: contact) // 預設顯示 Harry 名片
                    }
                }
            } else {
                // 無名片時顯示預設畫面
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

// UI 用的聯絡人分類資料結構
struct ContactCategoryUI: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let count: Int
}

// 聯絡人分類列表列元件
struct ContactCategoryRowView: View {
    let category: ContactCategoryUI
    var body: some View {
        HStack {
            Circle()
                .fill(category.color)
                .frame(width: 10, height: 10)
            Text(category.name)
            Spacer()
            Text("\(category.count)")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PeopleListView()
}
