//
//  D1397009View.swift
//  NameCard
//
//  Created by Guest User on 2025/9/9.
//

import SwiftUI

// Define a NameCard structure that conforms to the View protocol
struct D1397009View: View {
    var name: String
    var phoneNumber: String?
    var email: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let phone = phoneNumber {
                Text("Phone: \(phone)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Text("Email: \(email)")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Create a new NameCard instance (no longer needed for the preview)
// let myCard = D1397009View (
//     name: "陳昶介",
//     phoneNumber: "0912-345-678",
//     email: "D1397009@o365.fcu.edu.tw"
// )

// Add the PreviewProvider struct to enable live preview in Xcode
struct D1397009View_Previews: PreviewProvider {
    static var previews: some View {
        D1397009View(
            name: "陳昶介",
            phoneNumber: "0912-345-678",
            email: "D1397009@o365.fcu.edu.tw"
        )
    }
}
