//
//  LeoView.swift
//  NameCard
//
//  Created by Leo on 9/8/25.
//

import SwiftUI

struct LeoView: View {
    @State private var isFlipped = false
    @State private var floatingOffset: CGFloat = 0
    @State private var animationTimer: Timer?
    @State private var animationResetTrigger = false
    @State private var spotlightIntensity: Double = 0.3
    
    static let contact: Contact = Contact(
        firstName: "政佑",
        lastName: "林",
        title: "iOS Developer",
        organization: "Feng Chia University",
        email: "D1397159@o365.fcu.edu.tw",
        phone: "+886-888-888-888",
        address: "Taichung, Taiwan",
        website: "github.com/Leo890728",
        department: "AI Coding"
    )

    var body: some View {
        ZStack {
            // background
            Color.black
                .ignoresSafeArea()
            
            // Spotlight effect from top
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(spotlightIntensity), location: 0.0),
                    .init(color: Color.white.opacity(spotlightIntensity * 0.5), location: 0.2),
                    .init(color: Color.white.opacity(spotlightIntensity * 0.2), location: 0.4),
                    .init(color: Color.clear, location: 0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Additional radial spotlight effect
            RadialGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.white.opacity(spotlightIntensity * 0.4), location: 0.0),
                    .init(color: Color.white.opacity(spotlightIntensity * 0.2), location: 0.3),
                    .init(color: Color.clear, location: 0.7)
                ]),
                center: UnitPoint(x: 0.5, y: 0.15),
                startRadius: 50,
                endRadius: 400
            )
            .ignoresSafeArea()

            // Name Card
            ZStack {
                if !isFlipped {
                    // Front of card
                    LeoNameCardFront(contact: LeoView.contact, triggerAnimation: !isFlipped, animationResetTrigger: animationResetTrigger)
                        .opacity(isFlipped ? 0 : 1)
                } else {
                    // Back of card
                    LeoNameCardBack(contact: LeoView.contact, triggerAnimation: isFlipped, animationResetTrigger: animationResetTrigger)
                        .opacity(isFlipped ? 1 : 0)
                }
            }
            .frame(width: 370, height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.6),
                                Color.clear
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .shadow(color: .purple.opacity(0.3), radius: 20, x: 0, y: 10)
            .shadow(color: .blue.opacity(0.2), radius: 40, x: 0, y: 20)
            .offset(y: floatingOffset)
            .rotation3DEffect(
                .degrees(isFlipped ? -180 : 0),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.4
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.3)) {
                    isFlipped.toggle()
                }
                // 同步動畫
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    resetAllAnimations()
                }
            }
            .onAppear {
                startFloatingAnimation()
                startSpotlightAnimation()
            }
            .onDisappear {
                animationTimer?.invalidate()
            }
        }
    }
    
    private func startFloatingAnimation() {
        animationTimer?.invalidate()
        floatingOffset = 0
        
        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            floatingOffset = -8
        }
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            if floatingOffset == 0 || abs(floatingOffset) < 1 {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    floatingOffset = -8
                }
            }
        }
    }
    
    private func resetAllAnimations() {
        // 完全停止動畫
        animationTimer?.invalidate()
        
        // 重置到初始狀態
        withAnimation(.linear(duration: 0.1)) {
            floatingOffset = 0
        }
        
        // 短暫延遲後同步啟動所有動畫
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            animationResetTrigger.toggle()
            
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                floatingOffset = -8
            }
            
            animationTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                if floatingOffset == 0 || abs(floatingOffset) < 1 {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        floatingOffset = -8
                    }
                }
            }
        }
    }
    
    private func startSpotlightAnimation() {
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
            spotlightIntensity = 0.5
        }
    }
}

#Preview {
    LeoView()
}
