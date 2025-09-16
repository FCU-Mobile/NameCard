import SwiftUI

// 名片資料
struct NameCardInfo {
    let name: String
    let role: String
    let email: String
    let phone: String
    let location: String
}

struct NameCardCardView: View {
    var cardColor: Color
    var info: NameCardInfo

    // 統一管理棕色系（主色 / 次色 / 連絡資訊）
    private var primaryBrown: Color { Color(red: 0.34, green: 0.23, blue: 0.17) }        // 深棕
    private var secondaryBrown: Color { primaryBrown.opacity(0.80) }     // 次要文字
    private var contactBrown: Color { primaryBrown.opacity(0.50) }   // 連絡資訊

    var body: some View {
        ZStack {
            // ✨ 高質感卡片背景
            RoundedRectangle(cornerRadius: 60, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            cardColor.opacity(0.80),
                            cardColor.opacity(0.40),
                            Color.white.opacity(0.13)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 60, style: .continuous))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 60, style: .continuous)
                        .stroke(Color(red: 255/255, green: 220/255, blue: 70/255), lineWidth: 2.2)
                )
                .shadow(color: .black.opacity(0.13), radius: 16, x: 0, y: 8)

            // ⬇️ 名片內容
            VStack(alignment: .leading, spacing: 6) {
                Text(info.name)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundStyle(primaryBrown)

                Text(info.role)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundStyle(secondaryBrown)

                Spacer().frame(height: 18)

                VStack(alignment: .leading, spacing: 6) {
                    if !info.email.isEmpty {
                        Label(info.email, systemImage: "envelope.fill")
                            .symbolRenderingMode(.monochrome)   // 圖示跟文字同色
                            .foregroundStyle(contactBrown)
                    }
                    if !info.phone.isEmpty {
                        Label(info.phone, systemImage: "phone.fill")
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(contactBrown)
                    }
                    if !info.location.isEmpty {
                        Label(info.location, systemImage: "mappin.and.ellipse")
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(contactBrown)
                    }
                }
                .font(.system(size: 14, weight: .regular, design: .rounded))
            }
            .padding([.horizontal, .vertical], 28)
        }
        .frame(width: 350, height: 250)
    }
}

#Preview {
    let me = NameCardInfo(
        name: "陳亭瑜",
        role: "數學老師／活動企劃",
        email: "D1397193@o365.fcu.edu.tw",
        phone: "0981763802",
        location: "HsinChu, Taiwan"
    )
    NameCardCardView(cardColor: .pink, info: me)
}
