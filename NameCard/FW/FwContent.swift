//
//  FwContent.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/9.
//

import SwiftUI

// 名片內容視圖
struct FwContent: View {
    // 控制名片是否翻面
    @State private var isFlipped = false
    var body: some View {
        ZStack {
            if isFlipped {
                // 背面名片
                VStack {
                    // LOGO 圖片
                    Image("LOGO")
                        .resizable()
                        .frame(width: 120, height:120)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 8)
                }
                .frame(width: 380, height: 220)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 6)
                // 修正背面鏡像問題
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                // 正面名片
                ZStack {
                    // 名片底色
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 6)
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 2) {
                            // 公司名稱
                            Text("One Two Studio")
                                .font(.title3)
                                .bold()
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 6) {
                            // 姓名
                            Text("Xiao Fang-Wen")
                                .font(.title3)
                                .padding(6)
                            // 電話
                            Text("Phone : 0912-345-678")
                                .font(.callout)
                                .padding(4)
                            // 電子郵件
                            Text("Email：s102412090@gmail.com")
                                .font(.callout)
                        }
                    }
                    .padding(20)
                }
                .frame(width: 380, height: 220)
                .background(Color(.systemGroupedBackground))
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
    FwContent()
}
