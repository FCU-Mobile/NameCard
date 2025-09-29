import SwiftUI

struct NewCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var color: Color = .gray
    
    let existingNames: [String]
    let onSave: (String, Color) -> Void
    
    // 新增：可選顏色陣列（8個顏色）
    private let colorOptions: [Color] = [
        .red, .blue, .orange, .green, .pink, .purple, .gray, .yellow
    ]
    // 分兩排，每排4個
    private var colorRows: [[Color]] {
        [
            Array(colorOptions.prefix(4)),
            Array(colorOptions.suffix(4))
        ]
    }
    
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
                Section(header: Text("Category Details")) {
                    TextField("Category Name", text: $name)
                        .textInputAutocapitalization(.words)
                    // 顏色選擇區塊
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Color")
                            .font(.subheadline)
                            .padding(.bottom, 2)
                        VStack(spacing: 16) {
                            ForEach(0..<colorRows.count, id: \ .self) { row in
                                HStack(spacing: 28) {
                                    ForEach(colorRows[row], id: \ .self) { option in
                                        ZStack {
                                            Circle()
                                                .fill(option)
                                                .frame(width: 40, height: 40)
                                                .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
                                                .overlay(
                                                    color == option ?
                                                        Image(systemName: "checkmark")
                                                            .font(.system(size: 20, weight: .bold))
                                                            .foregroundColor(.white)
                                                    : nil
                                                )
                                                .onTapGesture {
                                                    color = option
                                                }
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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
