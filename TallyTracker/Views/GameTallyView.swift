//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct GameTallyView: View {
    
    @State var player1Score: Int
    
    @State var player2Score: Int
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
//                TallyButtonView(playerScore: player1Score, color: .blue, playerName: "Meghan")
//                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
                Divider()
                Spacer()
//                TallyButtonView(playerScore: player2Score, color: .red, playerName: "Greg")
//                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        GameTallyView(player1Score: 5, player2Score: 7)
    }
}
