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
                    Text("Logo")
                        .font(.system(size: 48, weight: .bold))
                        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.33)
                        .background(colorScheme == .dark ? .black : .white)
                        .ignoresSafeArea()
                        .colorInvert()
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
                    .frame(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.3)
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
