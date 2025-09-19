import SwiftUI

struct AshtonNameCardFront: View {
    
    let contact: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "bolt.shield")
                .font(.system(size: 60))
                .foregroundStyle(Color.hogwartsGold.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)

            Text(contact.displayName)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(Color.hogwartsGold)
                .padding(.bottom, 10)
            
            Text(contact.title)
                .font(.system(size: 18, weight: .light, design: .serif))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(Color.hogwartsGold.opacity(0.8))
                .padding(.bottom, 10)
            
            PulsingDividerView(isAgitated: false)
            
            AshtonContactRowMinimal(iconName: "envelope.fill", text: contact.email)
            AshtonContactRowMinimal(iconName: "phone.fill", text: contact.phone)
            AshtonContactRowMinimal(iconName: "safari.fill", text: contact.website)
            AshtonContactRowMinimal(iconName: "building.2.fill", text: contact.organization)
            
        }
        .padding(40)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    AshtonNameCardFront(contact: Contact.ashtonData)
}
