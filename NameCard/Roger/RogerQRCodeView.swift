//
//  RogerQRCodeView.swift
//  NameCard
//
//  Created by Roger on 12/30/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct RogerQRCodeView: View {
    let contactInfo: String

    var body: some View {
        if let qrImage = generateQRCode(from: contactInfo) {
            Image(uiImage: qrImage)
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .overlay(
                    Image(systemName: "qrcode")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(.black.opacity(0.7))
                )
        }
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.message = Data(string.utf8)
        filter.correctionLevel = "H" // High error correction for better scanning

        if let outputImage = filter.outputImage {
            // Scale up the QR code for crisp quality
            let transform = CGAffineTransform(scaleX: 12, y: 12)
            let scaledImage = outputImage.transformed(by: transform)

            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return nil
    }
}
