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
                // TODO: Move this ZStack to it's own subview.
                ZStack {
                    AppColors.primaryLightGreen
                        .cornerRadius(27.0)
                        .padding()
                    Text("Start Tallying Your Way To Victory!")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.4)
                        .frame(width: 300)
                    RoundedRectangle(cornerRadius: 27.0)
                        .stroke(lineWidth: 4)
                        .padding()
                }
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
                                           ,imageName: "Starburst")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                }
                NavigationLink {
                    CustomGameSetupView()
                } label: {
                    MainMenuGameButtonView(gameTitle: "House Rules",
                                           description: "Custom game.",
                                           imageName: "HouseRulesCube")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                }
                
                Spacer()
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
