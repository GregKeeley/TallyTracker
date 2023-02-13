//
//  ViewModifiers.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    /// Devices current orientation
    @Binding var orientation: UIDeviceOrientation
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                orientation = UIDevice.current.orientation
            }
    }
    
}
