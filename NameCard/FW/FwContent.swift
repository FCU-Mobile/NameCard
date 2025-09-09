//
//  FwContent.swift
//  NameCard
//
//  Created by 訪客使用者 on 2025/9/9.
//

import SwiftUI

struct FwContent: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 6)
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("One Two Studio")
                        .font(.title3)
                        .bold()
                }
                Divider()
                VStack(alignment: .leading, spacing: 6) {
                    Text("Xiao Fang-Wen")
                        .font(.title3)
                        .padding(6)
                    Text("Phone : 0912-345-678")
                        .font(.callout)
                        .padding(4)
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
    FwContent()
}
