////
////  MainTallyContentView.swift
////  TallyTracker
////
////  Created by Gregory Keeley on 2/12/23.
////
//
//import SwiftUI
//
//struct DeviceRotationViewModifier: ViewModifier {
//    
//    @Binding var orientation: UIDeviceOrientation
//    
//    func body(content: Content) -> some View {
//        content
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//                orientation = UIDevice.current.orientation
//            }
//    }
//}
//
//// A View wrapper to make the modifier easier to use
//extension View {
//    func onRotate(_ orientation: Binding<UIDeviceOrientation>) -> some View {
//        modifier(DeviceRotationViewModifier(orientation: orientation))
//    }
//}
//
//
//struct MainTallyContentView: View {
//    @State private var orientation = UIDevice.current.orientation
//    
//    @State var player1Score: Int
//    @State var player2Score: Int
//    
//    var body: some View {
////        Group {
//        ZStack {
//            if orientation.isPortrait {
//                TallyViewPortrait(player1Score: player1Score, player2Score: player2Score)
//            } else  {
//                TallyViewLandscape(player1Score: player1Score, player2Score: player2Score)
//            }
//        }
////        }
////        .onAppear {
////            if let scene = UIApplication.shared.connectedScenes.first,
////                let sceneDelegate = scene as? UIWindowScene,
////               sceneDelegate.interfaceOrientation.isPortrait {
////                orientation = .portrait
////            } else {
////                orientation = .landscapeLeft
////            }
////        }
//        .onRotate($orientation)
//    }
//    
//}
//
//struct MainTallyContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTallyContentView(player1Score: 0, player2Score: 0)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
