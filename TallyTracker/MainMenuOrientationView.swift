//
//  MainMenuOrientationView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuOrientationView: View {
    @State var orientation = UIDevice.current.orientation

        let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
    var body: some View {
        ZStack {
            if orientation == .portrait {
                MainMenuView()
            } else {
                MainMenuViewLandScape()
            }
            if orientation.isLandscape {
                            Text("LANDSCAPE")
                        } else {
                            Text("PORTRAIT")
                        }
        }
        .onAppear {
            orientation = UIDevice.current.orientation
        }
        .onReceive(orientationChanged) { _ in
                    self.orientation = UIDevice.current.orientation
                }
        .onRotate($orientation)
    }
}

struct MainMenuOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuOrientationView()
    }
}
