//
//  HadleyNameCardFront.swift
//  NameCard
//
//  Created by Hadley Liao on 9/8/25.
//

import SwiftUI
import SafariServices

struct HadleyNameCardFront: View {
    let contact: Contact
    @State private var showingSafari = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 姓名與身份
            VStack(alignment: .leading, spacing: 8) {
                Text("Hadley Liao")
                    .font(.system(size: 26, weight: .light, design: .rounded))
                    .foregroundColor(Color.white)
                    .tracking(2)
                    .padding(.top, 20)

                Text("Student")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Color.white) 
                    .tracking(1)
            }
            .padding(.horizontal, 30)

            Spacer()

            // 聯絡資訊
            VStack(alignment: .leading, spacing: 6) {
                ContactRowStyled(text: "d1397060@o365.fcu.edu.tw")
                ContactRowStyled(text: contact.phone)
                ContactRowStyled(text: contact.address)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .sheet(isPresented: $showingSafari) {
            SafariView(url: URL(string: "https://\(contact.website)") ?? URL(string: "https://google.com")!)
        }
    }
}
