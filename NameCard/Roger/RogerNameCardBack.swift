//
//  RogerNameCardBack.swift
//  NameCard
//
//  Created by Roger on 12/30/24.
//

import SwiftUI

struct RogerNameCardBack: View {
    let contact: Contact
    @State private var qrCodeScale: CGFloat = 0.8
    @State private var organizationOpacity: Double = 0

    var body: some View {
        ZStack {
            // Modern gradient background matching front
            LinearGradient(
                colors: [
                    Color(.systemTeal).opacity(0.6),
                    Color(.systemPurple).opacity(0.4),
                    Color(.systemBlue).opacity(0.8)
                ],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            
            VStack(spacing: 24) {
                Spacer()
                
                // Organization info with modern styling
                VStack(spacing: 16) {
                    Text(contact.organization)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .opacity(organizationOpacity)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)

                    Text(contact.department)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.2))
                        )
                        .opacity(organizationOpacity)
                }
                
                Spacer()

                // QR Code section with modern design
                VStack(spacing: 16) {
                    ZStack {
                        // QR Code background
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .frame(width: 100, height: 100)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        
                        RogerQRCodeView(contactInfo: contact.toVCard())
                            .frame(width: 90, height: 90)
                            .scaleEffect(qrCodeScale)
                    }

                    Text("SCAN TO CONNECT")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                        .tracking(1.5)
                }

                Spacer()
            }
            .padding(.horizontal, 28)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .scaleEffect(x: -1, y: 1) // Flip horizontally for correct reading when card is flipped
        .onAppear {
            // Animate QR code appearance
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 10).delay(0.3)) {
                qrCodeScale = 1.0
            }
            
            // Animate organization info
            withAnimation(.easeInOut(duration: 0.8).delay(0.1)) {
                organizationOpacity = 1.0
            }
        }
    }
}
