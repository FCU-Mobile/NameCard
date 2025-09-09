//
//  WilliumView.swift
//  NameCard
//
//  Created by fcuiecs on 2025/9/9.
//

import SwiftUI

struct BusinessCardView: View {
    // MARK: - Properties
    
    // 使用 @State 來追蹤卡片的翻轉狀態
    @State private var isFlipped = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // 將正面和背面視圖放在 ZStack 中
            // 這樣它們會重疊，我們可以根據 isFlipped 狀態來顯示其中一個
            if isFlipped {
                CardBackView()
            } else {
                CardFrontView()
            }
        }
        // 主要的動畫效果 Modifier
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0), // 根據 isFlipped 狀態決定旋轉角度
            axis: (x: 0.0, y: 1.0, z: 0.0)    // 沿著 Y 軸旋轉
        )
        .onTapGesture {
            // 當點擊時，使用動畫來改變 isFlipped 狀態
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isFlipped.toggle()
            }
        }
    }
}

// MARK: - Card Front View
struct CardFrontView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 個人資訊
            VStack(alignment: .leading) {
                Text("大菠蘿")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("FCU學費繳納師")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            
            Divider()
            
            // 聯絡資訊
            InfoRow(icon: "building.2.fill", text: "逢甲夜市")
            InfoRow(icon: "phone.fill", text: "+886 912 345 678")
            InfoRow(icon: "envelope.fill", text: "rickroll@example.com")
        }
        .padding(30)
        .frame(width: 350, height: 220)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        // 加上一點陰影讓卡片更有立體感
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Card Back View
struct CardBackView: View {
    // 圖片 URL
    private let imageUrl = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuauSkgn14vzp23W7QTi6nFF6JJjzoDxZZfwc-dGXhaj-DqI7hQflmsbKxnhO_8_8QOHA&usqp=CAU")
    
    var body: some View {
        // 使用 AsyncImage 來非同步載入網路圖片
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                // 圖片正在載入時顯示進度指示器
                ProgressView()
            case .success(let image):
                // 圖片成功載入後顯示
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                // 圖片載入失敗時顯示錯誤圖示
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 350, height: 220)
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        // 修正背面視圖因為旋轉而鏡像的問題
        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

// MARK: - Reusable Info Row View
// 為了程式碼的重用性與整潔，將資訊列抽取成一個獨立的 View
struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.tint) // <-- 將 .accent 改為 .tint
                .frame(width: 20)
            Text(text)
        }
    }
}


// MARK: - Preview
#Preview {
    BusinessCardView()
}

