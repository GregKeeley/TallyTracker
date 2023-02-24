//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    /// View model for the button to display the teams score and intercept gestures during a game.
    @StateObject var gameVM: GameViewModel
    /// Represents the team color.
    @State var teamColor: Color
    /// Represents the name of the team.
    @State var teamName: String
    /// Tracks the score of the team.
    @Binding var teamScore: Int
    /// Used to determine if this view model belongs to team 1.
    @State var isTeamOne: Bool
    ///
    @State var serveLimit: Int
    /// Tracks the current serve. Starts on 1; The first serve.
    @Binding var serveCount: Int
    ///
    @Binding var isPlayer1Serving: Bool
    ///
    @Binding var teamWins: [Color]
    
    @Binding var gameOver: Bool
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(teamColor.opacity(0.8))
                VStack {
                    HStack {
                        ForEach(0..<serveLimit, id: \.self) { serveLimit in
                            if isPlayer1Serving && isTeamOne {
                                if serveCount > serveLimit {
                                    Circle()
                                        .foregroundColor(teamColor.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(teamColor.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                }
                            } else if !isPlayer1Serving && !isTeamOne {
                                if serveCount > serveLimit {
                                    Circle()
                                        .foregroundColor(teamColor.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(teamColor.opacity(0.8))
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
                    Text(teamScore.description)
                        .font(.system(size: 148, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(teamColor.opacity(0.8))
                    // Team Name
                    if !teamName.isEmpty {
                        Text(teamName.prefix(12))
                            .font(.system(size: 32, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: .infinity)
                            .background(teamColor.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0))
                            .colorInvert()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                gameVM.increaseScore(isTeamOne: isTeamOne)
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                gameVM.decrementTeamScoreAndServe(isTeamOne: isTeamOne)
            })
        }
        
    }
    
    
    //MARK: - Previews
//    struct TallyButton_Previews: PreviewProvider {
//        static let viewModel1 = TallyButtonViewModel(color: .red,
//                                                     teamName: "Greg",
//                                                     teamScore: 0,
//                                                     isTeamOne: true,
//                                                     serveLimit: 3,
//                                                     isCurrentlyServing: true,
//                                                     serveCount: 0,
//                                                     scoreLimit: 10,
//                                                     teamWins: [],
//                                                     gameOver: false,
//                                                     matchLimit: 3)
//        static var viewModel2: TallyButtonViewModel {
//            let viewModel = TallyButtonViewModel(color: .blue,
//                                                 teamName: "Team2",
//                                                 teamScore: 0,
//                                                 isTeamOne: false,
//                                                 serveLimit: 3,
//                                                 isCurrentlyServing: false,
//                                                 serveCount: 0,
//                                                 scoreLimit: 10,
//                                                 teamWins: [],
//                                                 gameOver: false,
//                                                 matchLimit: 3)
//            return viewModel
//        }
//        static var previews: some View {
//            TallyButtonView(tallyButtonVM: viewModel1)
//                .frame(width: 400, height: 400)
//                .previewLayout(.sizeThatFits)
//            TallyButtonView(tallyButtonVM: viewModel2)
//                .frame(width: 400, height: 400)
//                .previewLayout(.sizeThatFits)
//        }
//    }
}
