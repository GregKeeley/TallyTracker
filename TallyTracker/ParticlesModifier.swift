//
//  ParticlesModifier.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/5/23.
//

import SwiftUI

struct ParticlesModifier: ViewModifier {
    // TODO: Figure out a good description of time here.
    @State var time = 1.0
    /// Effects how large the particles get aka scale up.
    @State var scale = 0.1
    /// The amount of time, in seconds the effect plays out.
    let duration = 5.0
    /// The number of particles to be displayed on the modifier.
    let numOfParticles = 80
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<numOfParticles, id: \.self) { index in
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
