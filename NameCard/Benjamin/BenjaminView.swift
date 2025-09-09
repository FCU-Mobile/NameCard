//
//  BenjaminView.swift
//  NameCard
//
//  Created by YuehBenjamin on 2025/9/9.
//

import SwiftUI

struct BenjaminView: View {
    @State private var isFlipped = false
    @State private var startTime = Date()
    
    let contact: Contact

    var body: some View {
        ZStack {
            // Background - 你可以改成自己喜歡的顏色
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Name Card
            ZStack {
                if !isFlipped {
                    // Front of card
                    BenjaminCardFront(contact: contact)
                        .opacity(isFlipped ? 0 : 1)
                } else {
                    // Back of card
                    BenjaminCardBack(contact: contact)
                        .opacity(isFlipped ? 1 : 0)
                }
            }
            .frame(width: 350, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .background(
                // 自定義背景樣式
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.05)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                    )
            )
            .shadow(color: .blue.opacity(0.3), radius: 20, x: 0, y: 10)
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
    BenjaminView(contact: Contact(
        firstName: "Yueh",
        middleName: "Benjamin",
        lastName: "Chou",
        title: "Computer Science Student",
        organization: "Feng Chia University",
        email: "shuoz4796@gmail.com",
        phone: "+886-988-874-574",
        address: "Taichung, Taiwan",
        website: "https://github.com/YuehBenjamin",
        department: "資訊工程學系"
    ))
}
