//
//  CustomGameSetupView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/16/23.
//

import SwiftUI

struct CustomGameSetupView: View {
    
    @State var player1Color = Color.red
    
    @State var player2Color = Color.blue
    
    @State var singlesModeSelected = true
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("House Rules")
                .underline()
                .padding()
            
            // SET POINTS
            HStack {
                Text("Set Points")
                Spacer()
                Button {
                    // Decrement set points
                } label: {
                    Text("-")
                }
                Text("0")
                Button {
                    // Increment set points
                } label: {
                    Text("+")
                }
            }
            .padding()
            
            // # of serves before rotation
            HStack {
                Text("# of serves per rotation")
                Spacer()
                Button {
                    // Decrement serves
                } label: {
                    Text("-")
                }
                Text("0")
                Button {
                    // Increment serves
                } label: {
                    Text("+")
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
                    .padding(.leading)
                Spacer()
                ColorPicker("", selection: $player2Color)
                    .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                    .padding(.leading)
                Text("Player 2")
                    .padding(.leading)
                Spacer()
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
                Spacer()
            }
            // Games Per Match
            HStack {
                Text("Game Per Match")
                Spacer()
                Button {
                    // Decrement serves
                } label: {
                    Text("-")
                }
                Text("0")
                Button {
                    // Increment serves
                } label: {
                    Text("+")
                }
            }
            .padding()
            
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
