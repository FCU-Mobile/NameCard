import SwiftUI
import SwiftData

struct StoredContactDetailView: View {
    @Bindable var contact: StoredContact
    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [ContactCategory]
    @State private var isEditing = false
    @State private var showingDeleteAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerView

                if isEditing {
                    editingForm
                } else {
                    contactDetails
                }
            }
            .padding()
        }
        .navigationTitle(contact.fullName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Done") {
                        isEditing = false
                    }
                } else {
                    Menu {
                        Button("Edit") {
                            isEditing = true
                        }

                        Button("Delete", role: .destructive) {
                            showingDeleteAlert = true
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .alert("Delete Contact", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                modelContext.delete(contact)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this contact? This action cannot be undone.")
        }
    }

    private var headerView: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(Color(hex: contact.category?.colorHex ?? "007AFF").gradient)
                .frame(width: 80, height: 80)
                .overlay {
                    Text(String(contact.firstName.first ?? "?").uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }

            Text(contact.fullName)
                .font(.title2)
                .fontWeight(.semibold)

            if !contact.title.isEmpty {
                Text(contact.title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if let category = contact.category {
                HStack {
                    Circle()
                        .fill(Color(hex: category.colorHex))
                        .frame(width: 8, height: 8)
                    Text(category.name)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private var contactDetails: some View {
        VStack(spacing: 16) {
            if !contact.organization.isEmpty {
                DetailRow(label: "Organization", value: contact.organization, icon: "building.2")
            }

            if !contact.department.isEmpty {
                DetailRow(label: "Department", value: contact.department, icon: "person.3")
            }

            if !contact.email.isEmpty {
                DetailRow(label: "Email", value: contact.email, icon: "envelope")
            }

            if !contact.phone.isEmpty {
                DetailRow(label: "Phone", value: contact.phone, icon: "phone")
            }

            if !contact.address.isEmpty {
                DetailRow(label: "Address", value: contact.address, icon: "location")
            }

            if !contact.website.isEmpty {
                DetailRow(label: "Website", value: contact.website, icon: "globe")
            }
        }
    }

    private var editingForm: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Personal Information")
                    .font(.headline)

                TextField("First Name", text: $contact.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Last Name", text: $contact.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Title", text: $contact.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Department", text: $contact.department)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Organization")
                    .font(.headline)

                TextField("Organization", text: $contact.organization)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Address", text: $contact.address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Contact Information")
                    .font(.headline)

                TextField("Email", text: $contact.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                TextField("Phone", text: $contact.phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)

                TextField("Website", text: $contact.website)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }

            if !categories.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.headline)

                    Picker("Category", selection: $contact.category) {
                        Text("None").tag(nil as ContactCategory?)
                        ForEach(categories, id: \.id) { category in
                            Text(category.name).tag(category as ContactCategory?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.body)
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
