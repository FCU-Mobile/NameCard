import SwiftUI

struct D1397009PeopleListView: View {
    @State private var people: [D1397009Person] = [
        D1397009Person(name: "陳昶介", phoneNumber: "0912-345-678", email: "D1397009@o365.fcu.edu.tw", category: "Education")
    ]
    
    @State private var categories: [String] = ["Education"] // ⬅️ 分類清單
    @State private var showAddPerson = false
    @State private var showAddCategory = false

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    Section(header: Text(category)) {
                        let filteredPeople = people.filter { $0.category == category }
                        ForEach(filteredPeople) { person in
                            NavigationLink(
                                destination: D1397009View(
                                    name: person.name,
                                    phoneNumber: person.phoneNumber,
                                    email: person.email
                                )
                            ) {
                                Text(person.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Directory")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddPerson = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }

                    Button(action: {
                        showAddCategory = true
                    }) {
                        Image(systemName: "folder.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $showAddPerson) {
                AddPersonView(people: $people, existingCategories: categories)
            }
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView(categories: $categories)
            }
        }
    }
}
