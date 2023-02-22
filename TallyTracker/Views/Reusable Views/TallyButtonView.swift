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
    @State var isTeamOne: Bool
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(isTeamOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                VStack {
                    HStack {
                        ForEach(0..<viewModel.serveLimit, id: \.self) { serveLimit in
                            if viewModel.isTeam1Serving && isTeamOne {
                                if viewModel.serveCount > serveLimit {
                                    Circle()
                                        .foregroundColor(isTeamOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(isTeamOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                }
                            } else if !viewModel.isTeam1Serving && !isTeamOne {
                                if viewModel.serveCount > serveLimit {
                                    Circle()
                                        .foregroundColor(isTeamOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(isTeamOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                }
                            }
                        }
                    }
                    .padding(.top, geo.size.height * 0.1)
                    Spacer()
                }
                
                VStack {
                    // Team Score
                    Text(isTeamOne ? viewModel.team1Score.description : viewModel.team2Score.description)
                        .font(.system(size: 148, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(isTeamOne ? viewModel.team1Color.opacity(0.8) : viewModel.team2Color.opacity(0.8))
                    // Team Name
                    if !viewModel.team1Name.isEmpty && !viewModel.team2Name.isEmpty {
                        Text(isTeamOne ? viewModel.team1Name.prefix(12) : viewModel.team2Name.prefix(12))
                            .font(.system(size: 32, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: .infinity)
                            .background(isTeamOne ?
                                        viewModel.team1Color.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0)
                                        : viewModel.team2Color.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0))
                            .colorInvert()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                if !viewModel.gameOver {
                    // Serve count is below or at the limit, increment count and continue.
                    if viewModel.serveCount < viewModel.serveLimit {
                        viewModel.serveCount += 1
                    } else {
                        // Serve count is above the limit, reset the count and toggle which side is serving.
                        viewModel.serveCount = 1
                        viewModel.isTeam1Serving.toggle()
                    }
                    // TEAM 1 tapped.
                    // Increase score depending on which side pressed the button.
                    if isTeamOne {
                        // Team score is below score limit, increment team score.
                        if viewModel.team1Score <= viewModel.scoreLimit {
                            if (viewModel.team1Score + 1) == viewModel.scoreLimit {
                                viewModel.matchComplete = true
                            }
                            viewModel.team1Score += 1
                        } else {
                            viewModel.team1Score = 0
                            viewModel.team2Score = 0
                            // Team 1 score has reached limit, winning the match.
                            if let indexOfPreviousWinner = viewModel.teamWins.lastIndex(where: { $0 != .gray }) {
                                if (indexOfPreviousWinner + 1) < viewModel.matchLimit {
                                    viewModel.teamWins[indexOfPreviousWinner + 1] = viewModel.team1Color
                                } else {
                                    // Game Over. Team 1 wins.
                                    viewModel.gameOver = true
                                }
                            } else {
                                viewModel.matchComplete = true
                                viewModel.teamWins[0] = viewModel.team1Color
                            }
                        }
                      
                    // TEAM 2 tapped.
                    } else {
                        if viewModel.team2Score < viewModel.scoreLimit {
                            viewModel.team2Score += 1
                        } else if viewModel.team2Score == viewModel.scoreLimit {
                            viewModel.team1Score = 0
                            viewModel.team2Score = 0
                            // Team 2 score has reached limit, winning the match.
                            if let indexOfPreviousWinner = viewModel.teamWins.lastIndex(where: { $0 != .gray }) {
                                if (indexOfPreviousWinner + 1) < viewModel.matchLimit {
                                    viewModel.teamWins[indexOfPreviousWinner + 1] = viewModel.team2Color
                                } else {
                                    // Game Over. Team 2 wins.
                                    viewModel.gameOver = true
                                }
                            } else {
                                // Match complete.
                                viewModel.matchComplete = true
                                viewModel.teamWins[0] = viewModel.team2Color
                            }
                        }
                    }
                }
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                if !viewModel.gameOver {
                    // Decrement score, and serve count with a long press.
                    if viewModel.serveCount > 1 {
                        viewModel.serveCount -= 1
                    }
                    if isTeamOne {
                        viewModel.team1Score -= 1
                    } else {
                        viewModel.team2Score -= 1
                    }
                }
            })
        }
    }
    
}


//MARK: - Previews
struct TallyButton_Previews: PreviewProvider {
    static let viewModel1 = GameViewModel(serveLimit: 5,
                                          scoreLimit: 11,
                                          team1Color: .red,
                                          team2Color: .blue,
                                          isTeam1Serving: true,
                                          matchLimit: 5)
    static var viewModel2: GameViewModel {
        let viewModel = GameViewModel(serveLimit: 5,
                                      scoreLimit: 11,
                                      team1Color: .red,
                                      team2Color: .blue,
                                      isTeam1Serving: false,
                                      matchLimit: 5)
        viewModel.team1Name = "Team1"
        viewModel.team2Name = "Greg"
        viewModel.serveCount = 3
        viewModel.serveLimit = 5
        return viewModel
    }
    static var previews: some View {
        TallyButtonView(viewModel: viewModel1, isTeamOne: true)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
        TallyButtonView(viewModel: viewModel2, isTeamOne: false)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
