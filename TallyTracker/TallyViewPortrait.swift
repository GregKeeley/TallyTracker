//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct TallyViewPortrait: View {
    
    @State var player1Score: Int
    
    @State var player2Score: Int
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    
    var body: some View {
        ZStack {
            Text("Portrait")
                .font(.system(size: 72, weight: .bold))
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
                        .rotationEffect(orientation == .portrait ? .degrees(90) : .degrees(0))
                }
                .onTapGesture {
                    player1Score += 1
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
                        .rotationEffect(orientation == .portrait ? .degrees(90) : .degrees(0))
                }
                .onTapGesture {
                    player2Score += 1
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        TallyViewPortrait(player1Score: 5, player2Score: 7)
    }
}
