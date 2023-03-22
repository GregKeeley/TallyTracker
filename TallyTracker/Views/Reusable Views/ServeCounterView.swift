//
//  ServeCounterView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/20/23.
//

import SwiftUI

struct ServeCounterView: View {
    /// Used to determine the color scheme of the users device for layout/color purposes.
    @Environment(\.colorScheme) var colorScheme
    /// View model for the button to display the teams score and intercept gestures during a game.
    @StateObject var gameVM: GameViewModel
    /// Tracks the current serve. Starts on 1; The first serve.
    @Binding var serveCount: Int
    
    @Binding var teamColor: Color
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
                ForEach(0..<gameVM.serveLimit, id: \.self) { serveLimit in
                    if serveCount > serveLimit {
                        ZStack {
                            Circle()
                                .frame(width: geo.size.width * 0.07)
                            Circle()
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .frame(width: geo.size.width / 16)
                                .offset(x: -0.5, y: -0.5)
                        }
                    } else {
                        ZStack {
                            Circle()
                                .frame(width: geo.size.width * 0.07)
                            Circle()
                                .foregroundColor(teamColor)
                                .frame(width: geo.size.width / 16)
                                .offset(x: -0.5, y: -0.5)
                        }
                    }
                    
                }
                Spacer()
            }
        }
    }
}



struct ServeCounterView_Previews: PreviewProvider {
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
        ServeCounterView(gameVM: buttonPreviewVM, serveCount: .constant(2), teamColor: .constant(.red))
    }
}
