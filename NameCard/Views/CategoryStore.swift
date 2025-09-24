import SwiftUI
import Combine

struct Category: Identifiable {
    let id = UUID()
    var name: String
    var color: Color
}

final class CategoryStore: ObservableObject {
    @Published var categories: [Category]
    
    init(categories: [Category] = CategoryStore.defaultCategories) {
        self.categories = categories
    }
    
    func addCategory(name: String, color: Color) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let key = trimmed.lowercased()
        guard !trimmed.isEmpty else { return }
        let existing = categories.map { $0.name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        guard !existing.contains(key) else { return }
        categories.append(Category(name: trimmed, color: color))
    }
}

extension CategoryStore {
    static let defaultCategories: [Category] = [
        Category(name: "Clients",       color: .red),
        Category(name: "Education",     color: .blue),
        Category(name: "Family",        color: .orange),
        Category(name: "Friends",       color: .green),
        Category(name: "Medical",       color: .pink),
        Category(name: "Services",      color: .purple),
        Category(name: "Vendors",       color: .purple),
        Category(name: "Work",          color: .blue),
        Category(name: "Uncategorized", color: .gray) // 修正拼字，供未分類暫存
    ]
}
