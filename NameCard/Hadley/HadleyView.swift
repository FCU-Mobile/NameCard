//
//  HadleyView.swift
//  NameCard
//
//  Created by Hadley Liao on 9/8/25.
//

import SwiftUI

struct HadleyView: View {
    @State private var isFlipped = false
    @State private var startTime = Date()
    
    let contact: Contact

    var body: some View {
        ZStack {
            // 背景改為科技感漸層
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Name Card
            ZStack {
                if !isFlipped {
                    HadleyNameCardFront(contact: contact)
                        .opacity(isFlipped ? 0 : 1)
                } else {
                    HadleyNameCardBack(contact: contact)
                        .opacity(isFlipped ? 1 : 0)
                }
            }
            .frame(width: 350, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.85), Color.purple.opacity(0.6)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.pink.opacity(0.4), lineWidth: 1.5)
                    )
            )
            .shadow(color: Color.purple.opacity(0.6), radius: 20, x: 0, y: 10)
            .rotation3DEffect(
                .degrees(isFlipped ? -180 : 0),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.3
            )
            .onTapGesture {
                withAnimation(.spring(response: 1.2, dampingFraction: 0.6, blendDuration: 0.2)) {
                    isFlipped.toggle()
                }
            }
            .onAppear {
                startTime = Date()
            }
        }
    }
}

#Preview {
    HadleyView(contact: Contact.sampleData)
}

