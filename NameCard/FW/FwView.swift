//
//  FwView.swift
//  NameCard
//
//  Created by Allison on 2025/9/19.
//

import SwiftUI

struct FwView: View {
    let contact: Contact
    // 控制名片是否翻面
    @State private var isFlipped = false
    var body: some View {
        ZStack {
            if isFlipped {
                // 背面名片
                FwCardBack()
                    // 修正背面鏡像問題
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                // 正面名片
                FwCardFront()
            }
        }
        .frame(width: 380, height: 220)
        // 3D 翻轉效果
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        // 翻轉動畫
        .animation(.easeInOut(duration: 0.5), value: isFlipped)
        // 點擊名片時翻面
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}

#Preview {
    FwView(contact: .FwStudent)
}
