//
//  ContactRow.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/23.
//

import SwiftUI

struct ContactRow: View {
    let text: String
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundStyle(.gray)
                .frame(width: 12)
            
            Text(text)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.black.opacity(0.8))
        }
    }
}
