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
    /// Height size class, used to determine available horizontal space available and handle layout on the device.
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    /// Width size class, used to determine available vertical space available and handle layout on the device.
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        if heightSizeClass == .regular && widthSizeClass == .compact {
            HStack {
                ForEach(0..<gameVM.matchLimit, id:\.self) { index in
                    OffsetCircleView(color: gameVM.totalTeamWinColors[index])
                }
            }
        } else {
            VStack {
                ForEach(0..<gameVM.matchLimit, id:\.self) { index in
                    OffsetCircleView(color: gameVM.totalTeamWinColors[index])
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
        viewModel.totalTeamWinColors = [.red, .blue, .white, .white, .white]
        return viewModel
    }()
    
    static var previews: some View {
        MatchWinsCounterView(gameVM: previewVM)
            .previewLayout(.sizeThatFits)
    }
}
