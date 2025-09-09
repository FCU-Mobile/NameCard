import SwiftUI

struct AnView: View {
    var body: some View {
        ZStack {
            // 背景色
            Color(.systemGray6)
                .ignoresSafeArea()
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 32) {
                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 52, height: 52)
                            .offset(x: -10)
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 52, height: 52)
                            .offset(x: 10)
                    }
                    VStack(alignment: .leading, spacing: 7) {
                        Text("陳俊諳")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.white)
                        Text("Design director")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.85))
                        Text("設計總監")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.85))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 148)
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 1.5, height: 94)
                    .padding(.horizontal, 6)
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("可劃軟體設計公司")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Text("AN DESIGN COMPANY")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.85))
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("TEL")
                                .font(.system(size: 12))
                                .frame(width: 38, alignment: .leading)
                                .foregroundColor(.white.opacity(0.85))
                            Text("001-12345678")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        HStack {
                            Text("E-MAIL")
                                .font(.system(size: 12))
                                .frame(width: 38, alignment: .leading)
                                .foregroundColor(.white.opacity(0.85))
                            Text("D1397030@fcu.com")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        HStack {
                            Text("ADD")
                                .font(.system(size: 12))
                                .frame(width: 38, alignment: .leading)
                                .foregroundColor(.white.opacity(0.85))
                            Text("台中市市政路１００號")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 6)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 26)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.black)
                    .shadow(color: .black.opacity(0.18), radius: 12, x: 0, y: 6)
            )
            .padding(.horizontal, 32)
            .padding(.vertical, 54)
        }
    }
}

#Preview {
    AnView()
}
