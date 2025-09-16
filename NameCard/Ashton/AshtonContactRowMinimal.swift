import SwiftUI

struct AshtonContactRowMinimal: View {
    let iconName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: iconName)
                .frame(width: 24)
                .foregroundStyle(.secondary)
            
            Text(text)
                .font(.system(size: 14))
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    VStack {
        AshtonContactRowMinimal(iconName: "envelope.fill", text: "contact@buildwithharry.com")
        AshtonContactRowMinimal(iconName: "phone.fill", text: "+886-909-007-162")
    }
    .padding()
}
