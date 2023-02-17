//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct GameTallyView: View {
    
    @ObservedObject var viewModel: GameViewModel
    /// Height size class, used to determine available horizontal space available and handle layout on the device.
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    /// Width size class, used to determine available vertical space available and handle layout on the device.
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            if heightSizeClass == .regular {
                VStack {
                    TallyButtonView(viewModel: viewModel, isPlayerOne: true, isPlayerServing: true)
                    Divider()
                    TallyButtonView(viewModel: viewModel, isPlayerOne: false, isPlayerServing: false)
                }
                .padding()
            } else {
                HStack {
                    TallyButtonView(viewModel: viewModel, isPlayerOne: true, isPlayerServing: true)
                    Divider()
                    TallyButtonView(viewModel: viewModel, isPlayerOne: false, isPlayerServing: false)
                }
                .padding()
            }
        }
    }
    
}



//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    
    static let viewModel = GameViewModel(serveLimit: 5, scoreLimit: 11, player1Color: .red, player2Color: .blue)
    
    static var previews: some View {
        GameTallyView(viewModel: viewModel)
    }
}
