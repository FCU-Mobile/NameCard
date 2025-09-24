//
//  FwCardFront.swift
//  NameCard
//
//  Created by Allison on 2025/9/19.
//

import SwiftUI

struct FwCardFront: View {
    var body: some View {
        ZStack {
            // 名片底色
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 6)
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    // 學生
                    Text("Student")
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

#Preview {
    FwCardFront()
}
