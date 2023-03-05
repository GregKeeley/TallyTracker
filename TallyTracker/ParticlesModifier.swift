//
//  ParticlesModifier.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/5/23.
//

import SwiftUI

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(ParticleGeometryEffect(time: time))
                    .opacity((duration - time) / duration)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
    
}
