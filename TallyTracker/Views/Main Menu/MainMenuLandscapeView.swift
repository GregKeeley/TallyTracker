//
//  MainMenuViewLandScape.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuLandscapeView: View {
    // MARK: - Properties and Variables
    /// Stores the users current color scheme (dark/light) to determine style in the view.
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Logo")
                        .font(.system(size: 48, weight: .bold))
                        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.17)
                        .background(colorScheme == .dark ? .black : .white)
                        .ignoresSafeArea()
                        .colorInvert()
                    Spacer()
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 28, height: 28)
                    .padding(.trailing)
                }
                Spacer()
                VStack {
                    HStack {
                        NavigationLink {
                            GameTallyView(viewModel: GameViewModel(serveLimit: 5,
                                                                   scoreLimit: 11,
                                                                   player1Color: .red,
                                                                   player2Color: .blue,
                                                                   isTeam1Serving: true,
                                                                   matchLimit: 5))
                        } label: {
                            // TODO: Refactor this button view to not have a reference directly to GameViewModel.
                            MainMenuGameButtonView(gameTitle: "Official Rules", message: "Play to 11. Win by 2. Best of 5.")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .isDetailLink(false)
                        Spacer(minLength: 40)
                        NavigationLink {
                            
                        } label: {
                            MainMenuGameButtonView(gameTitle: "House Rules", message: "Custom game.")
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
struct MainMenuViewLandScape_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuLandscapeView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
