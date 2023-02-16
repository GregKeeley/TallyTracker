//
//  CustomGameSetupView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/16/23.
//

import SwiftUI

struct CustomGameSetupView: View {
    /// Stores the users current color scheme (dark/light) to determine style in the view.
    @Environment(\.colorScheme) var colorScheme
    
    @State var maxScorePerGame: Int = 11
    @State var servesPerRotation: Int = 3
    @State var maxGamePerMatch: Int = 1
    
    @State var player1Color = Color.red
    
    @State var player2Color = Color.blue
    
    @State var singlesModeSelected = true
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            // House Rules
            Text("House Rules")
                .font(.system(size: 48, weight: .bold))
                .underline()
                .padding()
            
            // SET POINTS
            HStack {
                Text("Set Points")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Button {
                    // Decrement set points, 11 point minimum.
                    if maxScorePerGame > 10 {
                        maxScorePerGame -= 1
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 32, weight: .regular))
                }
                Text(maxScorePerGame.description)
                    .font(.system(size: 32, weight: .regular))
                Button {
                    // Increment set points, no maximum set.
                    maxScorePerGame += 1
                } label: {
                    Text("+")
                        .font(.system(size: 32, weight: .regular))
                }
            }
            .padding()
            
            // # of serves before rotation
            HStack {
                Text("# of serves per rotation")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Button {
                    // Decrement serves, only if above 3 serves.
                    if servesPerRotation > 3 {
                        servesPerRotation -= 1
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 32, weight: .regular))
                }
                Text(servesPerRotation.description)
                    .font(.system(size: 32, weight: .regular))
                Button {
                    // Increment serves, max of 7.
                    if servesPerRotation < 7 {
                        servesPerRotation += 1
                    }
                } label: {
                    Text("+")
                        .font(.system(size: 32, weight: .regular))
                }
            }
            .padding()
            
            
            // Team color
            HStack(alignment: .center) {
                Spacer()
                ColorPicker("", selection: $player1Color)
                    .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    .padding(.leading)
                // TODO: Replace these text strings with text fields to allow for changing of the player names.
                Text("Player 1")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.leading)
                Spacer()
                ColorPicker("", selection: $player2Color)
                    .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    .padding(.leading)
                Text("Player 2")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.leading)
                Spacer()
            }
            .padding()
            
            // Games Per Match
            HStack {
                Text("Game Per Match")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Button {
                    // Decrement game per match. 1 game minimum.
                    if maxGamePerMatch > 1 {
                        maxGamePerMatch -= 1
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 32, weight: .regular))
                }
                Text(maxGamePerMatch.description)
                    .font(.system(size: 32, weight: .regular))
                Button {
                    // Increment games per match, mo maxiumum.
                    maxGamePerMatch += 1
                } label: {
                    Text("+")
                        .font(.system(size: 32, weight: .regular))
                }
            }
            .padding()
            
            // Singles/Doubles selection
            HStack {
                Spacer()
                Button {
                    singlesModeSelected.toggle()
                } label: {
                    if singlesModeSelected {
                        Image(systemName: "square")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    } else {
                        Image(systemName: "x.square")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    }
                }
                Text("Singles")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Button {
                    singlesModeSelected.toggle()
                } label: {
                    if singlesModeSelected {
                        Image(systemName: "square")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    } else {
                        Image(systemName: "x.square")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    }
                }
                Text("Doubles")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    if servesPerRotation > 2 {
                        GameTallyView(viewModel: GameViewModel(serveLimit: servesPerRotation, scoreLimit: maxScorePerGame, player1Color: player1Color, player2Color: player2Color))
                    }
                } label: {
                    Text("BEGIN")
                        .font(.system(size: 48, weight: .bold))
                        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.5)
                        .background(colorScheme == .dark ? .black : .white)
                        .ignoresSafeArea()
                        .colorInvert()
                }
                Spacer()
            }
            Spacer()
        }
    }
    
}


//MARK: - Previews
struct CustomGameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGameSetupView()
    }
}
