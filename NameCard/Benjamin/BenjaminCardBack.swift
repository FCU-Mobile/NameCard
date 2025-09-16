//
//  BenjaminCardBack.swift
//  NameCard
//
//  Created by YuehBenjamin on 2025/9/9.
//

import SwiftUI

struct BenjaminCardBack: View {
    let contact: Contact

    var body: some View {
        VStack(spacing: 15) {
            Spacer()

            // Company/University info with different styling
            VStack(spacing: 10) {
                Text(contact.organization)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
                    .tracking(1)

                Text(contact.department)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.secondary)
                    .tracking(0.5)
            }

            Spacer()

            // QR Code section with custom styling
            VStack(spacing: 10) {
                QRCodeView(contactInfo: contact.toVCard())
                    .frame(width: 90, height: 90)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.3), radius: 5)

                Text("掃描加入聯絡人")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                    .tracking(0.5)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaleEffect(x: -1, y: 1) // Flip horizontally so text reads correctly when card is flipped
    }
}
