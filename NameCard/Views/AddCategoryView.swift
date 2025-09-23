//
//  AddCategoryView.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/23.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var categoryName = ""
    @State private var selectedColor = "007AFF"

    private let availableColors = [
        "007AFF", // Blue
        "34C759", // Green
        "FF9500", // Orange
        "FF3B30", // Red
        "AF52DE", // Purple
        "FF2D92", // Pink
        "5AC8FA", // Light Blue
        "FFCC02"  // Yellow
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Category Details") {
                    TextField("Category Name", text: $categoryName)
                }

                Section("Color") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                        ForEach(availableColors, id: \.self) { colorHex in
                            Button {
                                selectedColor = colorHex
                            } label: {
                                Circle()
                                    .fill(Color(hex: colorHex))
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        if selectedColor == colorHex {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 16, weight: .bold))
                                        }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCategory()
                    }
                    .disabled(categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveCategory() {
        let category = ContactCategory(
            name: categoryName.trimmingCharacters(in: .whitespacesAndNewlines),
            colorHex: selectedColor
        )

        modelContext.insert(category)
        try? modelContext.save()
        dismiss()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            let red = Double((hexNumber & 0xFF0000) >> 16) / 255
            let green = Double((hexNumber & 0x00FF00) >> 8) / 255
            let blue = Double(hexNumber & 0x0000FF) / 255

            self.init(red: red, green: green, blue: blue)
        } else {
            self.init(.blue)
        }
    }
}
