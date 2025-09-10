import SwiftUI

struct BusinessNameCardView: View {
    // 名片資料
    var name: String
    var title: String
    var phone: String
    var email: String
    var company: String
    var logo: Image
    var department: String
    

    // 狀態：是否翻轉
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            // 正面
            frontSide
                .opacity(isFlipped ? 0 : 1)

            // 背面（加上 180 度旋轉讓字變正）
            backSide
                .rotation3DEffect(.degrees(180), axis: (x:0, y:1, z:0))
                .opacity(isFlipped ? 1 : 0)
        }
        .frame(width: 350, height: 200)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemGray6), Color(.systemBlue).opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .shadow(color: .blue.opacity(0.15), radius: 10, x: 0, y: 6)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.blue.opacity(0.18), lineWidth: 1)
        )
        .rotation3DEffect(
            Angle.degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isFlipped)
        .onTapGesture {
            isFlipped.toggle()
        }
    }

    // 商務風格正面
    var frontSide: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                logo
                    .resizable()
                    .frame(width: 54, height: 54)
                    .cornerRadius(12)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(company)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            Divider()
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.green)
                Text(phone)
                    .font(.footnote)
                Spacer()
                Image(systemName: "envelope.fill")
                    .foregroundColor(.orange)
                Text(email)
                    .font(.footnote)
            }
        }
        .padding(24)
        .foregroundColor(.black)
    }

    // 背面：可放公司 Logo、公司名稱及標語
    var backSide: some View {
        VStack {
            Spacer()
            logo
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(20)
                .shadow(radius: 4)
            Text(company)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.blue)
                .padding(.top, 8)
            Text(department) // 這裡動態顯示公司/學校名稱
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top, 4)
            Spacer()
            Text("感謝您的聯絡！")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
        }
        .padding(24)
    }
}
