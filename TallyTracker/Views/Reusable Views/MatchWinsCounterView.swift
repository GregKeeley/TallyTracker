//
//  MatchWinsCounterView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/22/23.
//

import SwiftUI

struct MatchWinsCounterView: View {
    /// Used to determine the color scheme of the users device for layout/color purposes.
    @Environment(\.colorScheme) var colorScheme
    /// View model for the button to display the teams score and intercept gestures during a game.
    @StateObject var gameVM: GameViewModel
    
    var body: some View {
        HStack {
            ForEach(0..<gameVM.matchLimit, id:\.self) { index in
                if gameVM.totalTeamWinColors[index] == gameVM.firstTeamColor {
                    ZStack {
                        Circle()
                            .frame(width: 28)
                        Circle()
                            .frame(width: 24)
                            .foregroundColor(gameVM.firstTeamColor)
                            .offset(x: -0.5, y: -0.5)
                    }
                } else if gameVM.totalTeamWinColors[index] == gameVM.secondTeamColor {
                    ZStack {
                        Circle()
                            .frame(width: 28)
                        Circle()
                            .frame(width: 24)
                            .foregroundColor(gameVM.secondTeamColor)
                            .offset(x: -0.5, y: -0.5)
                    }
                } else {
                    ZStack {
                        Circle()
                            .frame(width: 28)
                        Circle()
                            .frame(width: 24)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .offset(x: -0.5, y: -0.5)
                    }
                }
            }
        }
    }
}


//MARK: - Previews
struct MatchWinsCounterView_Previews: PreviewProvider {
    static let previewVM: GameViewModel = {
        let viewModel = GameViewModel(serveLimit: 5,
                                      scoreLimit: 15,
                                      firstTeamColor: .red,
                                      secondTeamColor: .blue,
                                      firstTeamName: "Team 1",
                                      secondTeamName: "Team 2",
                                      firstTeamIsServing: true,
                                      matchLimit: 5,
                                      teamsAutomaticallySwitchSides: true)
        viewModel.totalTeamWinColors = [.red, .blue, .gray, .gray, .gray]
        return viewModel
    }()
    
    static var previews: some View {
        MatchWinsCounterView(gameVM: previewVM)
            .previewLayout(.sizeThatFits)
    }
}
