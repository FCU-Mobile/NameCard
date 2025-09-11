    //
    //  ZoeCardFront.swift
    //  NameCard
    //
    //  Created by YiJou  on 2025/9/10.
    //

import SwiftUI

extension ZoeCard {
    struct Front: View {
        let contact: Contact
        
        private let grad = LinearGradient(
            colors: [
                Color(red: 0.4, green: 0.80, blue: 0.75),
                Color(red: 0.4, green: 0.70, blue: 0.85)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        private var initials: String {
            let f = contact.firstName.first.map(String.init) ?? ""
            let l = contact.lastName.first.map(String.init) ?? ""
            return (f + l).uppercased()
        }
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(grad)
                    .overlay(
                        RadialGradient(colors: [.white.opacity(0.18), .clear],
                                       center: .topTrailing, startRadius: 12, endRadius: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    )
                
                VStack(spacing: 14) {
                    MonogramCircle(
                        initials: initials,
                        size: 64,
                        bg: LinearGradient(
                            colors: [
                                .white.opacity(0.20),
                                .white.opacity(0.10)
                            ],
                            startPoint: .topLeading, endPoint: .bottomTrailing),
                        fg: .white
                    )
                    .padding(.top, 6)
                    
                    Text(contact.displayName)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .tracking(2)
                    
                    Text(contact.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                    
                    Text(contact.organization)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(24)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(
                "\(contact.fullName), \(contact.title), \(contact.organization)"
            )
        }
    }
}
    
