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
                    Spacer()
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.trailing)
                }
                Spacer()
                HStack {
                    Spacer()
                    // TODO: Move this ZStack to it's own subview.
                    ZStack {
                        AppColors.primaryLightGreen
                        Text("Start Tallying Your Way To Victory!")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.4)
                            .frame(width: 300)
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke()
                            .padding()
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        NavigationLink(destination: GameTallyView(viewModel: GameViewModel(serveLimit: 5,
                                                                                           scoreLimit: 11,
                                                                                           firstTeamColor: .red,
                                                                                           secondTeamColor: .blue,
                                                                                           firstTeamName: "team1",
                                                                                           secondTeamName: "team2",
                                                                                           firstTeamIsServing: true,
                                                                                           matchLimit: 5,
                                                                                           teamsAutomaticallySwitchSides: true))) {
                            MainMenuGameButtonView(gameTitle: "Official Rules", description: "Play to 11. Win by 2. Best of 5.")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        Spacer(minLength: 40)
                        NavigationLink {
                            CustomGameSetupView()
                        } label: {
                            MainMenuGameButtonView(gameTitle: "House Rules", description: "Custom game.")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    .padding()
//                    .frame(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.3)
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
