//
//  MainMenuOrientationView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuOrientationView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    var body: some View {
        ZStack {
            if orientation == .portrait {
                MainMenuView()
            } else {
                Text("Not portrait")
            }
        }
        .onAppear {
            orientation = UIDevice.current.orientation
        }
        .onRotate($orientation)
    }
}

struct MainMenuOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuOrientationView()
    }
}
