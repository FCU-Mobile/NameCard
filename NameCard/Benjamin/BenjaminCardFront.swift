//
//  BenjaminCardFront.swift
//  NameCard
//
//  Created by YuehBenjamin on 2025/9/9.
//

import SwiftUI

struct BenjaminCardFront: View {
    let contact: Contact
    @State private var showingSafari = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section with decorative element
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(contact.displayName)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                        .tracking(1)
                        .padding(.top, 20)

                    Text(contact.title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.blue)
                        .tracking(0.5)
                }
                
                Spacer()
                
                // 裝飾性元素
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 20))
                            .foregroundStyle(.blue)
                    )
            }
            .padding(.horizontal, 25)

            Spacer()

            // Bottom section with contact info
            VStack(alignment: .leading, spacing: 8) {
                BenjaminContactRow(icon: "envelope.fill", text: contact.email, color: .blue)
                BenjaminContactRow(icon: "phone.fill", text: contact.phone, color: .green)
                BenjaminContactRow(icon: "location.fill", text: contact.address, color: .orange)

                // Tappable website
                Button(action: {
                    showingSafari = true
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "globe")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.blue)
                            .frame(width: 16)
                        
                        Text(contact.website)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.blue)
                            .underline()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .sheet(isPresented: $showingSafari) {
            SafariView(url: URL(string: contact.website.hasPrefix("http") ? contact.website : "https://\(contact.website)") ?? URL(string: "https://google.com")!)
        }
    }
}
