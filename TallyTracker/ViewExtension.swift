//
//  ViewExtension.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

extension View {
    // Wrapper for 'DeviceRotationViewModifier' to update a view when a devices orientation has changed.
    func onRotate(_ orientation: Binding<UIDeviceOrientation>) -> some View {
        modifier(DeviceRotationViewModifier(orientation: orientation))
    }
}
