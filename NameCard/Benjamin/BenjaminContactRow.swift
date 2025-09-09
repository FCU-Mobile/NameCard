//
//  BenjaminContactRow.swift
//  NameCard
//
//  Created by YuehBenjamin on 2025/9/9.
//

import SwiftUI

struct BenjaminContactRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(color)
                .frame(width: 16)
            
            Text(text)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondary)
        }
    }
}
