import SwiftUI

struct AshtonNameCardBack: View {
    let contact: Contact
    
    var body: some View {
        VStack {
            
            Text("Scan to Add Contact")
                .font(.headline)
            
            AshtonQRCodeView(urlString: contact.toVCard())

            Text(contact.organization)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    AshtonNameCardBack(contact: Contact.ashtonData)
}
