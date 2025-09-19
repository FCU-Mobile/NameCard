//
//  CYView.swift
//  NameCard
//
//  Created by Apple on 2025/9/9.
//

import SwiftUI

struct Info {
    var name : String
    var phone : String
    var address : String
}

struct MCView :View {
    let userInfo: Info
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
         
                VStack {
                    Image(systemName: "cloud.fill")
                        .font(.largeTitle)
                        .padding(.bottom, 5)
                    
                    Text(userInfo.name)
                        .font(.largeTitle)
                }
                .padding(40)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                )
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 3)
                )
                
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(userInfo.phone)
                    }
                    HStack {
                        Image(systemName: "house.fill")
                        Text(userInfo.address)
                    }
                }
                .font(.title2)
        
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .foregroundStyle(.white)
        
    }
}



#Preview {
    let MyData = Info(
        name: "MC",
        phone: "12345678",
        address: "臺中市西屯區文華路100號"
    )
    
    MCView(userInfo: MyData)
}
