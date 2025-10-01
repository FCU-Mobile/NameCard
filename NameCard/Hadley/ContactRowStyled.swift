import SwiftUI

struct ContactRowStyled: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .regular))
            .foregroundColor(Color.white.opacity(0.8))
            .tracking(0.8)
    }
}
