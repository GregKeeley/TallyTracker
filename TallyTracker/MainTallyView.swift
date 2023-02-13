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
                Text(orientation.rawValue.description)
                Spacer()
//                ZStack {
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke()
//                        .foregroundColor(.red.opacity(0.8))
//                    Text(player1Score.description)
//                        .font(.system(size: 148, weight: .bold))
//                        .minimumScaleFactor(0.5)
//                        .foregroundColor(.red.opacity(0.8))
//                        .rotationEffect(orientation == .portrait ? .degrees(0) : .degrees(90))
//                }
                TallyButtonView(playerScore: player1Score, color: .blue)
//                .onTapGesture {
//                    player1Score += 1
//                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
                Divider()
                Spacer()
//                ZStack {
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke()
//                        .foregroundColor(.blue.opacity(0.8))
//                    Text(player2Score.description)
//                        .font(.system(size: 148, weight: .bold))
//                        .minimumScaleFactor(0.5)
//                        .foregroundColor(.blue.opacity(0.8))
//                        .rotationEffect(orientation == .portrait ? .degrees(0) : .degrees(90))
//                }
                TallyButtonView(playerScore: player2Score, color: .red)
                .onTapGesture {
                    player2Score += 1
                }
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
