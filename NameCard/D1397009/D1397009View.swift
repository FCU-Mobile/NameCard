import SwiftUI

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
            }
            
            Text("Email: \(email)")
                .font(.headline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct D1397009View_Previews: PreviewProvider {
    static var previews: some View {
        D1397009View(
            name: "陳昶介",
            phoneNumber: "0912-345-678",
            email: "D1397009@o365.fcu.edu.tw"
        )
    }
}
