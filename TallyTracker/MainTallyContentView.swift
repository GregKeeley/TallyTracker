//
//  MainTallyContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/12/23.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}


struct MainTallyContentView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    
    @State var player1Score: Int
    @State var player2Score: Int
    
    var body: some View {
        Group {
            if orientation.isPortrait {
                TallyViewPortrait(player1Score: player1Score, player2Score: player2Score)
            } else if orientation.isLandscape {
                TallyViewLandscape(player1Score: player1Score, player2Score: player2Score)
            } else if orientation.isFlat {
                TallyViewLandscape(player1Score: player1Score, player2Score: player2Score)
            } else {
                Text("Unknown")
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .onAppear {
            if let scene = UIApplication.shared.connectedScenes.first,
                let sceneDelegate = scene as? UIWindowScene,
               sceneDelegate.interfaceOrientation.isPortrait {
                orientation = .portrait
            } else {
                orientation = .landscapeLeft
            }
        }
    }
    
}

struct MainTallyContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTallyContentView(player1Score: 0, player2Score: 0)
    }
}
