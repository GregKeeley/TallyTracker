//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct GameTallyView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                TallyButtonView(viewModel: TallyButtonViewModel(color: viewModel.player1Color, playerName: "", playerScore: 0))
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
                Divider()
                Spacer()
                TallyButtonView(viewModel: TallyButtonViewModel(color: viewModel.player2Color, playerName: "", playerScore: 0))
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
            }
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static let viewModel = GameViewModel(serveLimit: 5, scoreLimit: 11, player1Color: .red, player2Color: .blue)
    
    static var previews: some View {
        GameTallyView(viewModel: viewModel)
    }
}
