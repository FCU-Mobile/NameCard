//
//  LeoNameCardFront.swift
//  NameCard
//
//  Created by Leo on 9/14/25.
//

import SwiftUI
import SafariServices

struct LeoNameCardFront: View {
    let contact: Contact
    @State private var showingSafari = false
    @State private var rotationAngle: Double = 0
    let triggerAnimation: Bool
    let animationResetTrigger: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section with gradient background
            VStack(alignment: .leading, spacing: 6) {
                Text(contact.displayName)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                    .shadow(color: .white.opacity(0.5), radius: 1, x: 0, y: 1)
                    .padding(.top, 18)

                Text(contact.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray.opacity(0.8))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.1))
                    )
            }
            .padding(.horizontal, 22)

            Spacer()

            // Bottom section with contact info
            VStack(alignment: .leading, spacing: 6) {
                LeoContactRow(text: contact.email, icon: "envelope.fill")
                LeoContactRow(text: contact.phone, icon: "phone.fill")
                LeoContactRow(text: contact.address, icon: "location.fill")

                // website
                Button(action: {
                    showingSafari = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "globe")
                            .font(.system(size: 10))
                            .foregroundStyle(.blue)
                        
                        Text(contact.website)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.blue)
                            .underline()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 18)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white,
                    Color(red: 0.9, green: 0.95, blue: 1.0),
                    Color(red: 0.85, green: 0.85, blue: 0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .hueRotation(.degrees(rotationAngle))
        )
        .sheet(isPresented: $showingSafari) {
            SafariView(url: URL(string: "https://\(contact.website)") ?? URL(string: "https://google.com")!)
        }
        .onAppear {
            startAnimation()
        }
        .onChange(of: triggerAnimation) {
            startAnimation()
        }
        .onChange(of: animationResetTrigger) {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        rotationAngle = 0
        withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }
}
