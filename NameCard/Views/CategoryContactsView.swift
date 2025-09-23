//
//  CategoryContactsView.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/23.
//

import SwiftUI
import SwiftData

struct CategoryContactsView: View {
    let category: ContactCategory
    @Environment(\.modelContext) private var modelContext

    @Query private var allContacts: [StoredContact]
    @State private var showingAddContact = false

    private var categoryContacts: [StoredContact] {
        allContacts.filter { $0.category?.id == category.id }
            .sorted { $0.fullName < $1.fullName }
    }

    var body: some View {
        List {
            if categoryContacts.isEmpty {
                ContentUnavailableView(
                    "No Contacts",
                    systemImage: "person.slash",
                    description: Text("Add contacts to \(category.name) category")
                )
            } else {
                ForEach(categoryContacts) { contact in
                    NavigationLink(destination: StoredContactDetailView(contact: contact)) {
                        StoredContactRowView(contact: contact)
                    }
                }
                .onDelete(perform: deleteContacts)
            }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddContact = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddContact) {
            AddContactView()
        }
    }

    private func deleteContacts(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(categoryContacts[index])
        }
    }
}

struct StoredContactRowView: View {
    let contact: StoredContact

    var body: some View {
        HStack {
            Circle()
                .fill(Color(hex: contact.category?.colorHex ?? "007AFF"))
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 2) {
                Text(contact.fullName)
                    .font(.headline)

                if !contact.title.isEmpty {
                    Text(contact.title)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if !contact.organization.isEmpty {
                    Text(contact.organization)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }

            Spacer()

            VStack {
                if !contact.email.isEmpty {
                    Image(systemName: "envelope")
                        .foregroundStyle(.blue)
                        .font(.caption)
                }
                if !contact.phone.isEmpty {
                    Image(systemName: "phone")
                        .foregroundStyle(.green)
                        .font(.caption)
                }
            }
        }
        .padding(.vertical, 2)
    }
}
