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
                    Spacer()
                    TallyButtonView(viewModel: TallyButtonViewModel(color: viewModel.team1Color, playerName: viewModel.team1Name, playerScore: viewModel.player1Score, isPlayerOne: true))
                    Spacer()
                    Divider()
                    Spacer()
                    TallyButtonView(viewModel: TallyButtonViewModel(color: viewModel.team2Color, playerName: viewModel.team1Name, playerScore: viewModel.player1Score, isPlayerOne: false))
                    Spacer()
                }
                .padding()
            } else {
                HStack {
                    Spacer()
                    TallyButtonView(viewModel: TallyButtonViewModel(color: viewModel.team1Color, playerName: viewModel.team2Name, playerScore: viewModel.player2Score, isPlayerOne: true))
                    Spacer()
                    Divider()
                    Spacer()
                    TallyButtonView(viewModel: TallyButtonViewModel(color: viewModel.team2Color, playerName: viewModel.team2Name, playerScore: viewModel.player2Score, isPlayerOne: false))
                    Spacer()
                }
                .padding()
            }
        }
    }
    
}
    
    struct ContentView_Previews: PreviewProvider {
        
        static let viewModel = GameViewModel(serveLimit: 5, scoreLimit: 11, player1Color: .red, player2Color: .blue)
        
        static var previews: some View {
            GameTallyView(viewModel: viewModel)
        }
    }
