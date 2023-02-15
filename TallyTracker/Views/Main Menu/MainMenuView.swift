//
//  MainMenuView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

// TODO: Rename this to MainMenuPortraitView
struct MainMenuView: View {
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
                        MainMenuGameButtonView(gameTitle: "Official Rules", message: "Play to 11. Win by 2. Best of 5.")
                        Spacer(minLength: 40)
                        MainMenuGameButtonView(gameTitle: "House Rules", message: "Custom game.")
                    }
                    .frame(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.3)
                }
                Spacer()
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
