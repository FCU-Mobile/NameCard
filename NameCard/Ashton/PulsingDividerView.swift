// MARK: - PulsingDividerView.swift

import SwiftUI

struct PulsingDividerView: View {
    
    let isAgitated: Bool
    
    @State private var isPulsing = false
    
    private var pulseAnimation: Animation {
        if isAgitated {
            return Animation.easeInOut(duration: 0.3)
                .repeatForever(autoreverses: true)
        } else {
            return Animation.easeInOut(duration: 1.1)
                .repeatForever(autoreverses: true)
        }
    }
    
    var body: some View {

        Capsule()
            .fill(Color.hogwartsGold)
            .frame(height: 1)
            .scaleEffect(x: 1, y: isPulsing ? 1.5 : 1, anchor: .center)
            .shadow(color: .parchmentLight, radius: isPulsing ? 5 : 0)
            .animation(pulseAnimation, value: isPulsing)
            .onAppear {
                self.isPulsing = true
            }
    }
}
