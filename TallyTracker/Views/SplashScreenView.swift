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
                VStack {
                    Spacer(minLength: geo.size.height * 0.75)
                    NavigationLink {
                        MainMenuOrientationView()
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.08625)
                            Text("Start")
                                .foregroundColor(.white)
                        }
                    }
//                    Button {
//                        // Start Button
//                        NavigationLink(destination: MainMenuOrientationView()) {
//
//                        }
//                    } label: {
//                        ZStack {
//                            Capsule()
//                                .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.08625)
//                            Text("Start")
//                                .foregroundColor(.white)
//                        }
//                    }
                    Spacer()
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
