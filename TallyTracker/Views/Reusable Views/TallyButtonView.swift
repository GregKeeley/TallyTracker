//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
        @StateObject var tallyButtonVM: TallyButtonViewModel
//    @ObservedObject var tallyButtonVM: GameViewModel
    @State var isTeamOne: Bool
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(tallyButtonVM.color.opacity(0.8))
                VStack {
                    HStack {
                        ForEach(0..<tallyButtonVM.serveLimit, id: \.self) { serveLimit in
                            if tallyButtonVM.isCurrentlyServing {
                                if tallyButtonVM.serveCount > tallyButtonVM.serveLimit {
                                    Circle()
                                        .foregroundColor(tallyButtonVM.color.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(tallyButtonVM.color.opacity(0.8))
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
                    Text(tallyButtonVM.teamScore.description)
                        .font(.system(size: 148, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(tallyButtonVM.color.opacity(0.8))
                    // Team Name
                    if !tallyButtonVM.teamName.isEmpty {
                        Text(tallyButtonVM.teamName.prefix(12))
                            .font(.system(size: 32, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: .infinity)
                            .background(tallyButtonVM.color.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0))
                            .colorInvert()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                
//                if !tallyButtonVM.gameOver {
                    // Serve count is below or at the limit, increment count and continue.
                    if tallyButtonVM.serveCount < tallyButtonVM.serveLimit {
                        tallyButtonVM.serveCount += 1
                    } else {
                        // Serve count is above the limit, reset the count and toggle which side is serving.
                        tallyButtonVM.serveCount = 1
                        tallyButtonVM.isCurrentlyServing.toggle()
                    }
                    
                    // TEAM 1 tapped.
                    
                    // Increase score depending on which side pressed the button.
//                    if isTeamOne {
                        // Team score is below score limit, increment team score.
                        if tallyButtonVM.teamScore <= tallyButtonVM.scoreLimit {
//                            if (viewModel.team1Score + 1) == viewModel.scoreLimit {
//                                viewModel.matchComplete = true
//                            }
                            tallyButtonVM.teamScore += 1
                        } else {
                            tallyButtonVM.teamScore = 0
                            // Team 1 score has reached limit, winning the match.
                            if let indexOfPreviousWinner = tallyButtonVM.teamWins.lastIndex(where: { $0 != .gray }) {
                                if (indexOfPreviousWinner + 1) < tallyButtonVM.matchLimit {
                                    tallyButtonVM.teamWins[indexOfPreviousWinner + 1] = tallyButtonVM.team1Color
                                } else {
                                    // Game Over. Team 1 wins.
                                    tallyButtonVM.gameOver = true
                                }
                            } else {
                                tallyButtonVM.teamWins[0] = tallyButtonVM.team1Color
                            }
                        }
                        
                        // TEAM 2 tapped.
//                    } else {
//                        if tallyButtonVM.team2Score < tallyButtonVM.scoreLimit {
//                            tallyButtonVM.team2Score += 1
//                        } else if tallyButtonVM.team2Score == tallyButtonVM.scoreLimit {
//                            tallyButtonVM.team1Score = 0
//                            tallyButtonVM.team2Score = 0
//                            // Team 2 score has reached limit, winning the match.
//                            if let indexOfPreviousWinner = tallyButtonVM.teamWins.lastIndex(where: { $0 != .gray }) {
//                                if (indexOfPreviousWinner + 1) < tallyButtonVM.matchLimit {
//                                    tallyButtonVM.teamWins[indexOfPreviousWinner + 1] = tallyButtonVM.team2Color
//                                } else {
//                                    // Game Over. Team 2 wins.
//                                    tallyButtonVM.gameOver = true
//                                }
//                            } else {
//                                // Match complete.
//                                tallyButtonVM.matchComplete = true
//                                tallyButtonVM.teamWins[0] = tallyButtonVM.team2Color
//                            }
//                        }
//                    }
//                }
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                if !tallyButtonVM.gameOver {
                    // Decrement score, and serve count with a long press.
                    if tallyButtonVM.serveCount > 1 {
                        tallyButtonVM.serveCount -= 1
                    }
                    if isTeamOne {
                        tallyButtonVM.team1Score -= 1
                    } else {
                        tallyButtonVM.team2Score -= 1
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
        TallyButtonView(tallyButtonVM: viewModel1, isTeamOne: true)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
        TallyButtonView(tallyButtonVM: viewModel2, isTeamOne: false)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
