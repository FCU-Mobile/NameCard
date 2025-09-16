//
//  LeoNameCardBack.swift
//  NameCard
//
//  Created by Leo on 9/14/25.
//

import SwiftUI

struct LeoNameCardBack: View {
    let contact: Contact
    @State private var rotationAngle: Double = 0
    let triggerAnimation: Bool
    let animationResetTrigger: Bool

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            VStack(spacing: 12) {
                Text(contact.organization)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)

                Text(contact.department)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.gray.opacity(0.8))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.1))
                    )
            }

            Spacer()

            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 85, height: 85)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    
                    LeoQRCodeView(contactInfo: contact.toVCard())
                        .frame(width: 70, height: 70)
                }

                Text("SCAN TO CONNECT")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
                    .tracking(0.5)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.85, green: 0.85, blue: 0.9),
                    Color(red: 0.9, green: 0.95, blue: 1.0),
                    Color.white
                ]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .hueRotation(.degrees(rotationAngle))
        )
        .scaleEffect(x: -1, y: 1)
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
