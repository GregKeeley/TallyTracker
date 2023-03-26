//
//  GeometryEffect.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/5/23.
//

import SwiftUI

struct ParticleGeometryEffect: GeometryEffect {
    /// Duration of the particle effect.
    var time: Double
    /// Speed/Velocity of the particle effect. Different speeds give each particle individual looking effects.
    var speed: Double = Double.random(in: 20...200)
    /// Direction of the particle. Random direction ensure variety in the effect.
    var direction: Double = Double.random(in: -Double.pi...Double.pi)
    ///
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    /// Applies each of the properties to the particle effect.
    /// - Parameter size: Size of the particle.
    /// - Returns: 'ProjectionTransform' value for the particle.
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
    
}
