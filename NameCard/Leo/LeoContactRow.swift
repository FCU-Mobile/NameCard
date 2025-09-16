//
//  LeoContactRow.swift
//  NameCard
//
//  Created by Leo on 9/14/25.
//

import SwiftUI

struct LeoContactRow: View {
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
