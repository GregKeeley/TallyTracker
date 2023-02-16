//
//  CustomGameSetupView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/16/23.
//

import SwiftUI

struct CustomGameSetupView: View {
    
    @State var setPoints: Int = 0
    @State var servesPerRotation: Int = 0
    @State var gamePerMatch: Int = 0
    
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
                    // Decrement set points
                    if setPoints > 0 {
                        setPoints -= 1
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 32, weight: .regular))
                }
                Text(setPoints.description)
                    .font(.system(size: 32, weight: .regular))
                Button {
                    // Increment set points
                    setPoints += 1
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
                    // Decrement serves
                    if servesPerRotation > 0 {
                        servesPerRotation -= 1
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 32, weight: .regular))
                }
                Text(servesPerRotation.description)
                    .font(.system(size: 32, weight: .regular))
                Button {
                    // Increment serves
                    servesPerRotation += 1
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
                    // Decrement serves
                    if gamePerMatch > 0 {
                        gamePerMatch -= 1
                    }
                } label: {
                    Text("-")
                        .font(.system(size: 32, weight: .regular))
                }
                Text(gamePerMatch.description)
                    .font(.system(size: 32, weight: .regular))
                Button {
                    // Increment serves
                    gamePerMatch += 1
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
        }
    }
    
}


//MARK: - Previews
struct CustomGameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGameSetupView()
    }
}
