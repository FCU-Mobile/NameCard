//
//  ZoeCardBack.swift
//  NameCard
//
//  Created by YiJou  on 2025/9/10.
//

import SwiftUI

extension ZoeCard {
    private struct InfoLine: View {
        let label: String
        let value: String
        let color: Color
        
        var body: some View {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(label + ":")
                    .font(.callout.weight(.heavy))
                    .foregroundStyle(color)
                    .frame(width: 22, alignment: .leading)
                
                Text(value)
                    .font(.callout.weight(.medium))
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
                Spacer()
            }
        }
    }
    
    struct Back: View {
        let contact: Contact
        
        private let teal = Color(red: 0.13, green: 0.62, blue: 0.62)
        private let gradCircle = LinearGradient(
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
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.white)
                    .shadow(
                        color: .black.opacity(0.10), radius: 10, x: 0, y: 6)
                
                
                HStack(spacing: 16) {
                    MonogramCircle(
                        initials: initials,
                        size: 56,
                        bg: gradCircle,
                        fg: .white
                    )
                    .padding(.leading, 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 2){
                            Text(contact.displayName)
                                .font(.system(size: 18, weight: .heavy, design: .rounded))
                                .foregroundStyle(teal)
                            
                            Text(contact.title)
                                .font(.footnote.weight(.medium))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 2)
                        
                        InfoLine(label: "T", value: contact.phone, color: .orange)
                        InfoLine(label: "E", value: contact.email, color: .cyan)
                        InfoLine(
                            label: "W",
                            value: contact.website,
                            color: .indigo
                        )
                        
                        Text(contact.address)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.top, 2)
                    }
                    .padding(16)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel(
                    "\(contact.fullName). Phone\(contact.phone). Email \(contact.email). Website \(contact.website). Address \(contact.address)."
                )
            }
        }
    }
}
