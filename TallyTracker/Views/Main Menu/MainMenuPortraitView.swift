//
//  MainMenuView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuPortraitView: View {
    /// Stores the users current color scheme (dark/light) to determine style in the view.
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AppColors.primaryGreen
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image("ContextButton")
                            .padding(.leading)
                        Spacer()
                        Image("LogoWhite")
                        Spacer()
                        Image("SettingsButton")
                        //                        .resizable()
                        //                        .frame(width: 28, height: 28)
                            .padding(.trailing)
                    }
                    MainMenuMessageView()
                        .padding([.horizontal, .top])
                    Spacer(minLength: geo.size.height * 0.029)
                    NavigationLink(destination: GameTallyView(viewModel: GameViewModel(serveLimit: 5,
                                                                                       scoreLimit: 11,
                                                                                       firstTeamColor: .red,
                                                                                       secondTeamColor: .blue,
                                                                                       firstTeamName: "team1",
                                                                                       secondTeamName: "team2",
                                                                                       firstTeamIsServing: true,
                                                                                       matchLimit: 5,
                                                                                       teamsAutomaticallySwitchSides: true))) {
                        MainMenuGameButtonView(gameTitle: "Official Rules",
                                               description: "Play to 11. Win by 2. Best of 5."
                                               ,imageName: "StarburstRev")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                    Spacer(minLength: geo.size.height * 0.029)
                    NavigationLink {
                        CustomGameSetupView()
                    } label: {
                        MainMenuGameButtonView(gameTitle: "House Rules",
                                               description: "Customize to your rules.",
                                               imageName: "HouseRulesCube")
                        .foregroundColor(.black)
                        .padding([.horizontal, .bottom])
                    }
                    Spacer(minLength: geo.size.height * 0.029)
                }
            }
        }
    }
    
}



//MARK: - Previews
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuPortraitView()
    }
}
