//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    // MARK: - Variables/Properties
    /// Used to determine the color scheme of the users device for layout/color purposes.
    @Environment(\.colorScheme) var colorScheme
    /// View model for the button to display the teams score and intercept gestures during a game.
    @StateObject var gameVM: GameViewModel
    /// Represents the team color.
    @State var teamColor: Color
    /// Represents the name of the team.
    @State var teamName: String
    /// Tracks the score of the team.
    @Binding var teamScore: Int
    /// Used to determine if this view model belongs to team 1.
    @State var isFirstTeam: Bool
    /// The maximum numbers of serves before switching which team serves the ball.
    @State var serveLimit: Int
    /// Tracks the current serve. Starts on 1; The first serve.
    @Binding var serveCount: Int
    /// Determines if the first team is currently serving.
    /// Set to 'true' when the first team is currently serving to display the UI related to the current for that team.
    /// Set to 'false' when the second team is serving.
    @Binding var isfirstTeamServing: Bool
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 8)
                    .padding(8)
                    .foregroundColor(teamColor)
                // Background for the whole button so it is not transparent.
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .offset(x: -2, y: -2)
                    .padding(8)
                VStack {
                    HStack {
                        ForEach(0..<serveLimit, id: \.self) { serveLimit in
                            if isfirstTeamServing && isFirstTeam {
                                if serveCount > serveLimit {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .foregroundColor(teamColor)
                                            .frame(width: geo.size.width / 16)
                                            .offset(x: -0.5, y: -0.5)
                                    }
                                } else {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .foregroundColor(colorScheme == .dark ? .black : .white)
                                            .frame(width: geo.size.width / 16)
                                            .offset(x: -0.5, y: -0.5)
                                    }
                                }
                            } else if !isfirstTeamServing && !isFirstTeam {
                                if serveCount > serveLimit {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .foregroundColor(teamColor.opacity(0.8))
                                            .frame(width: geo.size.width / 16)
                                            .offset(x: -0.5, y: -0.5)
                                    }
                                } else {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .foregroundColor(colorScheme == .dark ? .black : .white)
                                            .frame(width: geo.size.width / 16)
                                            .offset(x: -0.5, y: -0.5)
                                    }
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
                        .foregroundColor(teamColor)
                    // Team Name
                    if !teamName.isEmpty {
                        Text(teamName.prefix(12))
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(teamColor)
//                            .background(teamColor.colorInvert().frame(width: geo.size.width / 3).cornerRadius(8.0))
//                            .colorInvert()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                gameVM.increaseScore(isFirstTeam: isFirstTeam)
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                gameVM.decrementTeamScoreAndServe(isFirstTeam: isFirstTeam)
            })
        }
        
    }
    
    
    
    //MARK: - Previews
    struct TallyButton_Previews: PreviewProvider {
        static let buttonPreviewVM = GameViewModel(serveLimit: 5,
                                                   scoreLimit: 15,
                                                   firstTeamColor: .red,
                                                   secondTeamColor: .blue,
                                                   firstTeamName: "Team 1",
                                                   secondTeamName: "Team 2",
                                                   firstTeamIsServing: true,
                                                   matchLimit: 5,
                                                   teamsAutomaticallySwitchSides: true)
        static var previews: some View {
            // First Team
            TallyButtonView(gameVM: buttonPreviewVM,
                            teamColor: buttonPreviewVM.firstTeamColor,
                            teamName: buttonPreviewVM.firstTeamName,
                            teamScore: .constant(buttonPreviewVM.firstTeamScore),
                            isFirstTeam: true,
                            serveLimit: buttonPreviewVM.serveLimit,
                            serveCount: .constant(buttonPreviewVM.serveCount),
                            isfirstTeamServing: .constant(buttonPreviewVM.isFirstTeamServing))
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
            // Second Team
            TallyButtonView(gameVM: buttonPreviewVM,
                            teamColor: buttonPreviewVM.secondTeamColor,
                            teamName: buttonPreviewVM.secondTeamName,
                            teamScore: .constant(buttonPreviewVM.secondTeamScore),
                            isFirstTeam: true,
                            serveLimit: buttonPreviewVM.serveLimit,
                            serveCount: .constant(buttonPreviewVM.serveCount),
                            isfirstTeamServing: .constant(buttonPreviewVM.isFirstTeamServing))
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
        }
    }
}
