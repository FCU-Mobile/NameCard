//
//  ChrisYoView.swift
//  NameCard
//
//  Created by chrisMini on 2025/9/9.
//

import SwiftUI

struct ChrisYoView: View {
    var body: some View {
        VStack(spacing: 50) {
            // 名片主體
            VStack {
                // 大頭照或公司 Logo
                Image("beagle-close-up-face")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                
                // 姓名
                Text("Chris Yo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                // 職位
                Text("Software Engineer")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .cornerRadius(20)
            .shadow(radius: 10)
            
            // 聯絡資訊
            VStack(alignment: .leading, spacing: 10) {
                InfoRow(iconName: "phone.fill", text: "04-2451-7250")
                InfoRow(iconName: "envelope.fill", text: "D1397129@fcu.edu.tw")
                InfoRow(iconName: "globe", text: "https://www.fcu.edu.tw/")
            }
            .padding()
            .cornerRadius(10)
        }
        .padding()
    }
}

// 聯絡資訊的輔助視圖
struct InfoRow: View {
    var iconName: String
    var text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: iconName)
                .foregroundStyle(.gray)
            Text(text)
                .foregroundStyle(.primary)
        }
    }
}


#Preview {
    ChrisYoView()
}
