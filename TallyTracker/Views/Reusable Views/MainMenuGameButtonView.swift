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
    /// Name of the image from assets to be loaded onto the view.
    // TODO: Make an enum for the image names.
    @State var imageName: String
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                AppColors.standardWhite
                    .cornerRadius(27.0)
                RoundedRectangle(cornerRadius: 27.0)
                    .stroke(lineWidth: 4)
                VStack {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(gameTitle)
                                .font(Font.custom(AppFonts.poppinsSemiBold, size: 26))
                                .fontWeight(Font.Weight.bold)
//                                .minimumScaleFactor(0.4)
                            Spacer()
                            Text(description)
                                .font(Font.custom(AppFonts.poppinsRegular, size: 18))
                                .fontWeight(Font.Weight.regular)
//                                .minimumScaleFactor(0.4)
                        }
                        .padding()
                        Spacer()
                    }
                    
                    HStack {
                        Image(imageName)
                            .padding(.leading)
                        Spacer()
                        Image("StartArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.5)
                            .padding(.trailing)
                    }
                    .padding(.bottom)
                    Spacer()
                }
            }
        }
    }
    
}



//MARK: - Previews
struct MainMenuGameButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainMenuGameButtonView(gameTitle: "Official Rules",
                               description: "Play to 11. Win by 2. Best of 5.",
                               imageName: "Starburst")
        .previewLayout(.sizeThatFits)
    }
}
