//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    @StateObject var viewModel: GameViewModel
    @State var playerScore: Int
    @State var color: Color
    @State var playerName: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        ZStack {
//                            Text(playerName)
//                                .font(.system(size: 32, weight: .regular))
//                                .frame(maxWidth: .infinity)
//                                .background(color.opacity(0.8).colorInvert())
//                                .colorInvert()
//                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(color.opacity(0.8))
                Text(playerScore.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(color.opacity(0.8))
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                playerScore += 1
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                playerScore -= 1
            })
        }
    }
    
}



struct TallyButton_Previews: PreviewProvider {
    static let viewModel = GameViewModel(serveLimit: 11)
    static var previews: some View {
        TallyButtonView(viewModel: viewModel, playerScore: 5, color: .green, playerName: "Gregory")
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
