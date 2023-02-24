//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    /// View model for the button to display the teams score and intercept gestures during a game.
    @StateObject var tallyButtonVM: TallyButtonViewModel
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(tallyButtonVM.teamColor.opacity(0.8))
                VStack {
                    HStack {
                        ForEach(0..<tallyButtonVM.serveLimit, id: \.self) { serveLimit in
                            if tallyButtonVM.isCurrentlyServing {
                                if tallyButtonVM.serveCount > tallyButtonVM.serveLimit {
                                    Circle()
                                        .foregroundColor(tallyButtonVM.teamColor.opacity(0.8))
                                        .frame(width: geo.size.width / 16)
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(tallyButtonVM.teamColor.opacity(0.8))
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
                        .foregroundColor(tallyButtonVM.teamColor.opacity(0.8))
                    // Team Name
                    if !tallyButtonVM.teamName.isEmpty {
                        Text(tallyButtonVM.teamName.prefix(12))
                            .font(.system(size: 32, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: .infinity)
                            .background(tallyButtonVM.teamColor.opacity(0.8).colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0))
                            .colorInvert()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                tallyButtonVM.increaseScore()
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                tallyButtonVM.decrementTeamScoreAndServe()
            })
        }
        
    }
    
    
    //MARK: - Previews
    struct TallyButton_Previews: PreviewProvider {
        static let viewModel1 = TallyButtonViewModel(color: .red,
                                                     teamName: "Greg",
                                                     teamScore: 0,
                                                     isTeamOne: true,
                                                     serveLimit: 3,
                                                     isCurrentlyServing: true,
                                                     serveCount: 0,
                                                     scoreLimit: 10,
                                                     teamWins: [],
                                                     gameOver: false,
                                                     matchLimit: 3)
        static var viewModel2: TallyButtonViewModel {
            let viewModel = TallyButtonViewModel(color: .blue,
                                                 teamName: "Team2",
                                                 teamScore: 0,
                                                 isTeamOne: false,
                                                 serveLimit: 3,
                                                 isCurrentlyServing: false,
                                                 serveCount: 0,
                                                 scoreLimit: 10,
                                                 teamWins: [],
                                                 gameOver: false,
                                                 matchLimit: 3)
            return viewModel
        }
        static var previews: some View {
            TallyButtonView(tallyButtonVM: viewModel1)
                .frame(width: 400, height: 400)
                .previewLayout(.sizeThatFits)
            TallyButtonView(tallyButtonVM: viewModel2)
                .frame(width: 400, height: 400)
                .previewLayout(.sizeThatFits)
        }
    }
}
