// MARK: - AshtonView.swift

import SwiftUI

struct AshtonView: View {
    
    let contact: Contact
    
    @State private var isFlipped = false
    @State private var isBorderPulsing = false
    @State private var isBorderAgitated = false
    
    private var borderPulseAnimation: Animation {
        if isBorderAgitated {
            return Animation.easeInOut(duration: 0.3)
                .repeatForever(autoreverses: true)
        } else {
            return Animation.easeInOut(duration: 2.0)
                .repeatForever(autoreverses: true)
        }
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [.parchmentLight, .parchmentDark, .parchmentLight]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.hogwartsBrown, lineWidth: 10)
                    .scaleEffect(isBorderPulsing ? 1.01 : 0.99)
                    .animation(borderPulseAnimation, value: isBorderPulsing)
                    .onAppear {
                        isBorderPulsing = true
                    }
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.hogwartsGold, lineWidth: 1)
                    .padding(12)
                    .scaleEffect(isBorderPulsing ? 1.01 : 0.99)
                    .shadow(color: .hogwartsGold, radius: isBorderPulsing ? 10 : 0)
                    .animation(borderPulseAnimation, value: isBorderPulsing)
                    .onAppear {
                        isBorderPulsing = true
                    }
                
                let cornerSymbol = Image(systemName: "fleuron.fill")
                                        .font(.title)
                                        .foregroundStyle(Color.hogwartsGold)
                
                cornerSymbol.position(x: 35, y: 35)
                cornerSymbol.position(x: geometry.size.width - 35, y: 35)
                cornerSymbol.position(x: 35, y: geometry.size.height - 35)
                cornerSymbol.position(x: geometry.size.width - 35, y: geometry.size.height - 35)
            }
            .frame(width: 350, height: 550)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.05))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
            .allowsHitTesting(false)
            .rotation3DEffect(.degrees(isFlipped ? 540 : 0), axis: (x: 0, y: 1, z: 0))
            
            
            ZStack {
                if isFlipped {
                    AshtonNameCardBack(contact: contact)
                } else {
                    AshtonNameCardFront(contact: contact)
                }
            }
            .frame(width: 300,height: 370)
            .foregroundStyle(Color.hogwartsGold)
            .shadow(radius: 10)
            .rotation3DEffect(.degrees(isFlipped ? 540 : 0), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation(.spring(response: 1, dampingFraction: 2)) {
                    isFlipped.toggle()
                }
            }
        }
    }
}

#Preview {
    AshtonView(contact: Contact.sampleData[1])
}
