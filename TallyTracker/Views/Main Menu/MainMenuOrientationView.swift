//
//  MainMenuOrientationView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

/// This view houses the view for both horizontal and vertical layouts for the main menu. Depending on the available width and height, the view will switch what view is displayed.
struct MainMenuOrientationView: View {
    /// Height size class, used to determine available horizontal space available and handle layout on the device.
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    /// Width size class, used to determine available vertical space available and handle layout on the device.
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            if heightSizeClass == .regular {
                MainMenuPortraitView()
            } else if heightSizeClass == .compact {
                MainMenuLandscapeView()
            }
        }
    }
    
}



struct MainMenuOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuOrientationView()
    }
}
