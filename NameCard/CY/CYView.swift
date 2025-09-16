//
//  CYView.swift
//  NameCard
//
//  Created by Harry Ng on 9/9/25.
//

import SwiftUI

struct CYView: View {
    // Sample contact data for CY
    private let cyContact = Contact(
        firstName: "Chun-Yu",
        lastName: "Chen",
        title: "Software Engineer",
        organization: "Feng Chia University",
        email: "cy.chen@fcu.edu.tw",
        phone: "+886 4 2451 7250",
        address: "No. 100, Wenhwa Rd., Seatwen, Taichung 40724, Taiwan",
        website: "www.fcu.edu.tw",
        department: "Computer Science"
    )
    
    @State private var showingSafari = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Top section with name and title
                VStack(alignment: .leading, spacing: 8) {
                    Text(cyContact.displayName)
                        .font(.system(size: 24, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .tracking(2)
                        .padding(.top, 20)

                    Text(cyContact.title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                        .tracking(1)
                    
                    Text(cyContact.organization)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray.opacity(0.8))
                        .tracking(0.5)
                }
                .padding(.horizontal, 30)

                Spacer()

                // Bottom section with contact info
                VStack(alignment: .leading, spacing: 6) {
                    ContactRowMinimal(text: cyContact.email)
                    ContactRowMinimal(text: cyContact.phone)
                    ContactRowMinimal(text: cyContact.address)

                    // Tappable website
                    Button(action: {
                        showingSafari = true
                    }) {
                        Text(cyContact.website)
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(.blue.opacity(0.8))
                            .tracking(0.5)
                            .underline()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .sheet(isPresented: $showingSafari) {
            SafariView(url: URL(string: "https://\(cyContact.website)") ?? URL(string: "https://google.com")!)
        }
    }
}

#Preview {
    CYView()
        .frame(width: 350, height: 200)
}
