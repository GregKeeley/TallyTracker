//
//  MainTallyContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/12/23.
//

import SwiftUI

struct MainTallyContentView: View {
    
    @State private var orientation = UIDevice.current.orientation
    
    @State var player1Score: Int
    @State var player2Score: Int
    
    var body: some View {
//        Group {
        ZStack {
            if orientation.isPortrait {
                MainTallyContentView(player1Score: player1Score, player2Score: player2Score)
            } else if orientation.isLandscape {
                TallyViewLandscape(orientation: orientation, player1Score: player1Score, player2Score: player2Score)
            }
        }
//        }
//        .onAppear {
//            if let scene = UIApplication.shared.connectedScenes.first,
//                let sceneDelegate = scene as? UIWindowScene,
//               sceneDelegate.interfaceOrientation.isPortrait {
//                orientation = .portrait
//            } else {
//                orientation = .landscapeLeft
//            }
//        }
        .onRotate($orientation)
    }
    
}

struct MainTallyContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTallyContentView(player1Score: 0, player2Score: 0)
//            .previewInterfaceOrientation(.landscapeLeft)
    }
}
