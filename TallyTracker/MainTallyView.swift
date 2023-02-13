//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct MainTallyView: View {
    
    @State var player1Score: Int
    @State var player2Score: Int
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                TallyButtonView(playerScore: player1Score, color: .blue)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
                Divider()
                Spacer()
                TallyButtonView(playerScore: player2Score, color: .red)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
            }
            .padding()
        }
        .onRotate($orientation)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTallyView(player1Score: 5, player2Score: 7)
    }
}
