//
//  MainMenuOrientationView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuOrientationView: View {
    
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            if heightSizeClass == .regular && widthSizeClass == .compact {
                MainMenuView()
            } else {
                MainMenuViewLandScape()
            }
        }
    }
}

struct MainMenuOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuOrientationView()
    }
}
