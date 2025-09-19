//
//  YMNameCard.swift
//  NameCard
//
//  Created by 張郁眉 on 2025/9/13.
//

import SwiftUI




struct YMNameCardBack: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.ultraThinMaterial) // 可以試 ultraThinMaterial / thinMaterial
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .overlay(
                LinearGradient(
                    colors: [Color.white.opacity(0.4), .clear],
                    startPoint: .top,
                    endPoint: .center
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
            )
            .frame(width: 300, height: 180)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .overlay(
                VStack(spacing: 12){
                    
                        Text("Contact me")
                        .font(.footnote)
                                            .foregroundStyle(.secondary)
                        
                    
            
                    
                    
                    HStack(spacing:20){
                        Image("YM")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Image("YMLine")         // 第二張圖片
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                }
            )
    }
}

#Preview {
    YMNameCardBack()
}
