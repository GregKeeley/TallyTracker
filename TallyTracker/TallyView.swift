//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct TallyView: View {
    
    @State var player1Score: Int
    @State var player2Score: Int
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(.red.opacity(0.8))
                Text(player1Score.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.red.opacity(0.8))
                    .rotationEffect(.degrees(180))
                    .onTapGesture {
                        player1Score += 1
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
            Spacer()
            Divider()
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(.blue.opacity(0.8))
                Text(player2Score.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.blue.opacity(0.8))
                    .onTapGesture {
                        player2Score += 1
                    }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        TallyView(player1Score: 3, player2Score: 2)
    }
}
