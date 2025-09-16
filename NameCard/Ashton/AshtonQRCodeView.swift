import SwiftUI
import CoreImage.CIFilterBuiltins

struct AshtonQRCodeView: View {
    let urlString: String
    
    
    var qrCodeImage: Image {
        return Image(systemName: "qrcode")
    }
    
    var body: some View {
        qrCodeImage
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .padding(16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 5)
    }
}

#Preview {
    AshtonQRCodeView(urlString: "https://buildwithharry.com")
        .frame(width: 200, height: 200)
        .padding()
        .background(.gray.opacity(0.2))
}
