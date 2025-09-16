//
//  ZoeCard.swift
//  NameCard
//
//  Created by YiJou  on 2025/9/10.
//

import SwiftUI

enum ZoeCard {}

extension ZoeCard {
    
    struct MonogramCircle: View {
        let initials: String
        let size: CGFloat
        let bg: LinearGradient
        let fg: Color
        var body: some View {
            ZStack {
                Circle()
                    .fill(bg)
                
                Text(initials.uppercased())
                    .font(.system(size: size * 0.6, weight: .heavy, design: .rounded))
                    .foregroundStyle(fg)
                    .tracking(1.2)
            }
            
            .frame(width: size, height: size)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
            
        }
    }
}

