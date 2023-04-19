//
//  MainMenuGameButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuGameButtonView: View {
    // MARK: - Variables/Properties
    /// Main title of button. Displays name of the game style for the user to choose.
    @State var gameTitle: String
    /// Message displayed below the game title, to describer the rules of the games.
    @State var description: String
    
    var body: some View {
        ZStack {
            AppColors.standardWhite
                .cornerRadius(27.0)
            RoundedRectangle(cornerRadius: 27.0)
                .stroke(lineWidth: 4)
            HStack {
                VStack(alignment: .leading) {
                    Text(gameTitle)
                        .font(.system(size: 32, weight: .bold))
                        .minimumScaleFactor(0.4)
                    Text(description)
                        .font(.system(size: 24, weight: .regular))
                        .minimumScaleFactor(0.4)
                }
                .padding()
                Image(systemName: "x.circle")
                    .resizable()
                    .padding(40)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
}



//MARK: - Previews
struct MainMenuGameButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainMenuGameButtonView(gameTitle: "Official Rules", description: "Play to 11. Win by 2. Best of 5.")
            .previewLayout(.sizeThatFits)
    }
}
