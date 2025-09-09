import SwiftUI

struct BusinessCardView: View {
    @State private var isFlipped = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("我的數位名片")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 名片
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 350, height: 220)
                    .shadow(radius: 10)
                
                if !isFlipped {
                    // 正面
                    VStack(spacing: 15) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Text("Grace Chang")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("逢甲大學學生")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                } else {
                    // 背面
                    VStack(alignment: .leading, spacing: 10) {
                        ContactRow(icon: "envelope.fill", text: "D1397278@o365.fcu.edu.tw")
                        ContactRow(icon: "graduationcap.fill", text: "逢甲大學")
                        ContactRow(icon: "location.fill", text: "台中市西屯區")
                        ContactRow(icon: "swift", text: "SwiftUI 學習中")
                        ContactRow(icon: "book.fill", text: "資訊工程系")
                    }
                    .padding(.horizontal, 20)
                }
            }
            .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.8)) {
                    isFlipped.toggle()
                }
            }
            
            Text(isFlipped ? "點擊返回正面" : "點擊查看聯絡資訊")
                .font(.caption)
                .foregroundColor(.secondary)
            
            // 按鈕
            HStack(spacing: 20) {
                ActionButton(title: "分享", icon: "square.and.arrow.up", color: .green)
                ActionButton(title: "儲存", icon: "square.and.arrow.down", color: .blue)
                ActionButton(title: "編輯", icon: "pencil", color: .orange)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContactRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 20)
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 14))
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button {
            print("\(title) 按鈕被點擊")
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(.white)
            .frame(width: 70, height: 50)
            .background(color)
            .cornerRadius(10)
        }
    }
}

#Preview {
    BusinessCardView()
}
