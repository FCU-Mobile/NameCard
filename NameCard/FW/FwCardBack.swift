//
//  FwCardBack.swift
//  NameCard
//
//  Created by Allison on 2025/9/19.
//

import SwiftUI

struct FwCardBack: View {
    var body: some View {
        VStack {
            // LOGO 圖片
            Image("LOGO")
                .resizable()
                .frame(width: 120, height:120)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 8)
        }
        .frame(width: 380, height: 220)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 6)
    }
}

#Preview {
    FwCardBack()
}
