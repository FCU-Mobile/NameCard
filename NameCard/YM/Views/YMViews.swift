import SwiftUI

let demoCard = YUNameCardModel(
    name: "Yu Mei Chang",
    phone: "0936-568-086",
    email: "lovec8c81@gmail.com",
    title: "iOS leaner",

    company: "Student Of FCU",
    note:"不喜歡上班",
)

// 背景：多彩模糊「光斑」讓玻璃更有折射感
struct YMViews: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .indigo, .blue, .mint],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            // 彩色光斑（被玻璃模糊後更有層次）
            Circle().fill(.pink.opacity(0.6)).frame(width: 240).blur(radius: 60).offset(x: -120, y: -140)
            Circle().fill(.teal.opacity(0.6)).frame(width: 260).blur(radius: 70).offset(x: 130, y: 120)
            Circle().fill(.yellow.opacity(0.45)).frame(width: 180).blur(radius: 55).offset(x: -10, y: 80)

            YMNameCardFlipView(model: demoCard)
        }
    }
}


#Preview { YMViews() }
