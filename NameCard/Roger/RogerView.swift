//
//  RogerView.swift
//  NameCard
//
//  Created by Roger on 12/30/24.
//

import SwiftUI

struct RogerView: View {
    @State private var isFlipped = false
    @State private var rotationAngle: Double = 0
    @State private var cardScale: CGFloat = 1.0
    
    let contact: Contact

    var body: some View {
        ZStack {
            // Modern gradient background
            LinearGradient(
                colors: [
                    Color(.systemBlue).opacity(0.1),
                    Color(.systemPurple).opacity(0.05),
                    Color(.systemBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Name Card with modern iOS 17+ styling
            ZStack {
                if !isFlipped {
                    // Front of card
                    RogerNameCardFront(contact: contact)
                        .opacity(isFlipped ? 0 : 1)
                } else {
                    // Back of card
                    RogerNameCardBack(contact: contact)
                        .opacity(isFlipped ? 1 : 0)
                }
            }
            .frame(width: 360, height: 230)
            .background(
                // Modern card background with materials
                RoundedRectangle(cornerRadius: 16)
                    .fill(.regularMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [.white.opacity(0.3), .clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
            )
            .shadow(
                color: .black.opacity(0.15),
                radius: 20,
                x: 0,
                y: 10
            )
            .scaleEffect(cardScale)
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 15)) {
                    isFlipped.toggle()
                }
                
                // Subtle scale animation
                withAnimation(.easeInOut(duration: 0.1)) {
                    cardScale = 0.98
                }
                withAnimation(.easeInOut(duration: 0.1).delay(0.1)) {
                    cardScale = 1.0
                }
            }
        }
    }
}

#Preview {
    RogerView(contact: Contact.rogerSampleData)
}
