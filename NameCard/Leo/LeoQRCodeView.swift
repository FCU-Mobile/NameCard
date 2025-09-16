//
//  LeoQRCodeView.swift
//  NameCard
//
//  Created by Leo on 9/14/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct LeoQRCodeView: View {
    let contactInfo: String

    var body: some View {
        if let qrImage = generateQRCode(from: contactInfo) {
            Image(uiImage: qrImage)
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.white)
                .cornerRadius(8)
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .overlay(
                    Image(systemName: "qrcode")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                )
        }
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"

        if let outputImage = filter.outputImage {
            // Scale up the QR code for better quality
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)

            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return nil
    }
}
