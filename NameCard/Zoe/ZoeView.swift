    //
    //  ZoeView.swift
    //  NameCard
    //
    //  Created by Zoe Chen on 9/8/25.
    //

import SwiftUI

struct ZoeView: View {
    @State private var isFlipped = false
    
    let contact: Contact
    
    var body: some View {
        ZStack {
                // Background
            
            LinearGradient(colors: [Color(red: 0.03, green: 0.07, blue: 0.28),
                                    Color(red: 0.00, green: 0.16, blue: 0.52)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
                // Name Card
            ZStack {
                if !isFlipped {
                        // Front of card
                    ZoeCard.Front(contact: contact)
                        .opacity(isFlipped ? 0 : 1)
                } else {
                        // Back of card
                    ZoeCard.Back(contact: contact)
                        .opacity(isFlipped ? 1 : 0)
                }
            }
            .frame(width: 350, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            .background(
                // Dark minimalist background
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            )
            .onTapGesture {
                withAnimation(.spring(response: 1.0, dampingFraction: 0.65, blendDuration: 0.15)) {
                    isFlipped.toggle()
                }
            }
            
        }
    }
}

#Preview {
    ZoeView(contact: .zoeStudent)
    
}
