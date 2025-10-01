//
//  HadleyNameCardBack.swift
//  NameCard
//
//  Created by Hadley Liao on 9/8/25.
//

import SwiftUI

struct HadleyNameCardBack: View {
    let contact: Contact
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // 學校/部門資訊
            VStack(spacing: 12) {
                Text(contact.organization)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                
                Text("SCAN TO CONNECT")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.white.opacity(0.85))
                
                
                Spacer()
                
                // QR Code 區塊
                VStack(spacing: 12) {
                    HadleyQRCodeView(contactInfo: contact.toVCard())
                        .frame(width: 80, height: 80)
                    
                    Text("SCAN TO CONNECT")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.gray)
                        .tracking(1)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(x: -1, y: 1) // 翻轉
        }
    }
}
