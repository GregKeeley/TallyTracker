//
//  SplashScreenView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/14/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.green
                    .ignoresSafeArea()
                Color.white.opacity(0.5)
                    .frame(height: geo.size.height * 0.025)
                Color.white.opacity(0.5)
                    .frame(width: geo.size.height * 0.025)
                    .ignoresSafeArea()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
