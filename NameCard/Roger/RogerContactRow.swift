//
//  RogerContactRow.swift
//  NameCard
//
//  Created by Roger on 12/30/24.
//

import SwiftUI

struct RogerContactRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.9))
                .frame(width: 16)
            
            Text(text)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.95))
                .lineLimit(1)
        }
    }
}
