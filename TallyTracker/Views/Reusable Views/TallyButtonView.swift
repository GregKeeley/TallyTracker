//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    //    @StateObject var viewModel: TallyButtonViewModel
    @ObservedObject var viewModel: GameViewModel
    @State var isPlayerOne: Bool
    @State var isPlayerServing: Bool
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(isPlayerOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                VStack {
                    HStack {
                        ForEach(0..<viewModel.serveLimit, id: \.self) { num in
                            if isPlayerServing {
                                if viewModel.serveCount > num {
                                    Circle()
                                        .foregroundColor(isPlayerOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(isPlayerOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                }
                            }
                        }
                    }
                    .padding(.top, geo.size.height * 0.1)
                    Spacer()
                }
                
                VStack {
                    // Player Score
                    Text(isPlayerOne ? viewModel.player1Score.description : viewModel.player2Score.description)
                        .font(.system(size: 148, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(isPlayerOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                    // Player Name
                    if !viewModel.team1Name.isEmpty && !viewModel.team2Name.isEmpty {
                        Text(isPlayerOne ? viewModel.team1Name.prefix(12) : viewModel.team2Name.prefix(12))
                            .font(.system(size: 32, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: .infinity)
                            .background(isPlayerOne ?
                                        viewModel.team1Color.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0)
                                        : viewModel.team2Color.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0))
                            .colorInvert()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                viewModel.serveCount += 1
                if isPlayerOne {
                    viewModel.player1Score += 1
                } else {
                    viewModel.player2Score += 1
                }
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                viewModel.serveCount -= 1
                if isPlayerOne {
                    viewModel.player1Score -= 1
                } else {
                    viewModel.player2Score -= 1
                }
            })
        }
    }
    
}


//MARK: - Previews
struct TallyButton_Previews: PreviewProvider {
    static let viewModel1 = GameViewModel(serveLimit: 5, scoreLimit: 11, player1Color: .red, player2Color: .blue)
    static var viewModel2: GameViewModel {
        let viewModel = GameViewModel(serveLimit: 5, scoreLimit: 11, player1Color: .red, player2Color: .blue)
        viewModel.team1Name = "Team1"
        viewModel.team2Name = "Greg"
        viewModel.serveCount = 3
        viewModel.serveLimit = 5
        return viewModel
    }
    static var previews: some View {
        TallyButtonView(viewModel: viewModel1, isPlayerOne: true, isPlayerServing: false)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
        TallyButtonView(viewModel: viewModel2, isPlayerOne: false, isPlayerServing: true)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
