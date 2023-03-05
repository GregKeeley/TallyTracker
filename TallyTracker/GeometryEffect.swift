//
//  GeometryEffect.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/5/23.
//

import SwiftUI

struct ParticleGeometryEffect: GeometryEffect {
    var time: Double
    var speed: Double = Double.random(in: 20...200)
    var direction: Double = Double.random(in: -Double.pi...Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
    
}
