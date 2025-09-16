//
//  RogerNameCardFront.swift
//  NameCard
//
//  Created by Roger on 12/30/24.
//

import SwiftUI
import SafariServices

struct RogerNameCardFront: View {
    let contact: Contact
    @State private var showingSafari = false
    @State private var animateGradient = false

    var body: some View {
        ZStack {
            // Animated gradient background
            LinearGradient(
                colors: [
                    Color(.systemBlue).opacity(0.8),
                    Color(.systemPurple).opacity(0.6),
                    Color(.systemTeal).opacity(0.4)
                ],
                startPoint: animateGradient ? .topLeading : .bottomTrailing,
                endPoint: animateGradient ? .bottomTrailing : .topLeading
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                // Header section with modern typography
                VStack(alignment: .leading, spacing: 12) {
                    Text(contact.displayName)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                        .padding(.top, 24)

                    Text(contact.title)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.2))
                                .backdrop(BlurEffect())
                        )
                }
                .padding(.horizontal, 28)

                Spacer()

                // Contact information with modern styling
                VStack(alignment: .leading, spacing: 8) {
                    RogerContactRow(icon: "envelope.fill", text: contact.email)
                    RogerContactRow(icon: "phone.fill", text: contact.phone)
                    RogerContactRow(icon: "location.fill", text: contact.address)
                    
                    // Interactive website button
                    Button(action: {
                        showingSafari = true
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "globe")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white)
                            
                            Text(contact.website)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.25))
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white.opacity(0.3), lineWidth: 1)
                                )
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 28)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .sheet(isPresented: $showingSafari) {
            RogerSafariView(url: URL(string: "https://\(contact.website)") ?? URL(string: "https://google.com")!)
        }
    }
}

// Custom backdrop effect for iOS 17+
struct BlurEffect: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

extension View {
    func backdrop<T: View>(_ content: T) -> some View {
        self.background(content)
    }
}
