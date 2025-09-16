import SwiftUI

// MARK: - 資料結構 & 山丘形狀 (保持不變)
struct Info {
    var name : String
    var fullName: String
    var phone : String
    var address : String
}

struct HillShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.maxY * 0.8),
            control: CGPoint(x: rect.width * 0.5, y: rect.maxY * 0.6)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - 動畫風車 (保持不變)
struct WindmillView: View {
    @State private var rotationAngle: Angle = .zero
    
    private var blade: some View {
        Capsule()
            .fill(Color.white.opacity(0.9))
            .frame(width: 15, height: 60)
            .shadow(radius: 2)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color.white.opacity(0.7))
                .frame(width: 4, height: 200)

            ZStack {
                Circle().fill(.white).frame(width: 18)
                Circle().stroke(Color.gray, lineWidth: 1).frame(width: 18)
                ForEach(0..<4) { i in
                    blade
                        .offset(y: -35)
                        .rotationEffect(.degrees(Double(i) * 90))
                }
            }
            .rotationEffect(rotationAngle)
            .offset(y: -190)
            .onAppear {
                withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                    rotationAngle = .degrees(360)
                }
            }
        }
    }
}


// MARK: - 主視圖 (已微調)
struct MCView :View {
    let userInfo: Info
    let backgroundColor = Color(red: 0.3, green: 0.5, blue: 0.45)
    
    var body: some View {
        ZStack {
            // MARK: - 1. 背景層 (山丘)
            VStack {
                Spacer()
                HillShape()
                    .fill(backgroundColor.shadow(.inner(color: .black.opacity(0.3), radius: 10)))
                    .frame(height: 120)
            }

            // MARK: - 2. 內容層 (風車 + 文字)
            // 【修改點 2】增加 spacing，讓資訊欄右移
            HStack(alignment: .top, spacing: 30) {
                // 左側：動畫風車
                WindmillView()
                    // 【修改點 1】增加 top padding，讓風車下來一點
                    .padding(.top, 35)

                // 右側：文字資訊
                VStack(alignment: .leading) {
                    Text(userInfo.name)
                        // 【修改點 3】將字體大小從 60 改為 52
                        .font(.system(size: 52, weight: .bold))
                        .frame(height: 70)
                    
                    Grid(alignment: .leading, horizontalSpacing: 12) {
                        GridRow {
                            Text("NAME:")
                                .font(.headline).foregroundStyle(.white.opacity(0.7))
                            Text(userInfo.fullName)
                        }
                        GridRow {
                            Text("TEL:")
                                .font(.headline).foregroundStyle(.white.opacity(0.7))
                            Text(userInfo.phone)
                        }
                        GridRow {
                            Text("ADD:")
                                .font(.headline).foregroundStyle(.white.opacity(0.7))
                            Text(userInfo.address)
                                .lineLimit(1).minimumScaleFactor(0.8)
                        }
                    }
                    .font(.system(size: 20, weight: .regular))
                    .padding(.top, 20)
                }
                .padding(.top, 35)
                
                Spacer()
            }
            .padding(.leading, 30)
            
        }
        .frame(width: 400, height: 320)
        .background(backgroundColor)
        .foregroundStyle(.white)
        .cornerRadius(20)
        .clipped()
    }
}


// MARK: - 預覽
#Preview {
    let MyData = Info(
        name: "MC",
        fullName: "旼謙",
        phone: "12345678",
        address: "臺中市西屯區文華路100號"
    )
    
    MCView(userInfo: MyData)
        .padding()
}
