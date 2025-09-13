//
//  YMNameCardFlipView.swift
//  NameCard
//
//  Created by 張郁眉 on 2025/9/13.
//

import SwiftUI

struct YMNameCardFlipView: View {
    @State private var flipped = false
    let model: YUNameCardModel
    var body: some View {
        ZStack{
            YMNameCardFront(model: model)
                .opacity(flipped ?  0 : 1 )
                .rotation3DEffect(.degrees(flipped ? 180 : 0),
                                                  axis: (x: 0, y: 1, z: 0))
            YMNameCardBack()
                           .opacity(flipped ? 1 : 0)
                           .rotation3DEffect(.degrees(flipped ? 0 : -180),
                                             axis: (x: 0, y: 1, z: 0))
                   
        }
        .rotation3DEffect(.degrees(0), axis: (x: 0, y: 0, z: 0), perspective: 0.8)
                .animation(.easeInOut(duration: 0.6), value: flipped)
                .onTapGesture { flipped.toggle() }
    }
}


