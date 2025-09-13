//
//  YMNameCard.swift
//  NameCard
//
//  Created by 張郁眉 on 2025/9/13.
//

import SwiftUI




struct YMNameCardFront: View {
    let model:YUNameCardModel
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
                VStack(alignment: .leading, spacing: 10) {
                    Text(model.name)
                        .font(.title2).bold()
                        .foregroundColor(.white)
                    
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(model.phone)
                    }
                    .foregroundColor(.white.opacity(0.9))
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text(model.email)
                    }
                    .foregroundColor(.white.opacity(0.9))
                    
                    HStack {
                        Image(systemName: "highlighter")
                        Text(model.note)
                    }
                    .foregroundColor(.white.opacity(0.9))
                   
                    
                    Spacer()
                    
                    
                    if let company = model.company{
                        HStack{
                            Spacer()
                            Text(company)
                                .font(.footnote)
                                                    .foregroundStyle(.secondary)
                        }
                    }
                }
                    .padding(18)
            )
    }
}

#Preview {
    YMNameCardFront(model: demoCard)
}
