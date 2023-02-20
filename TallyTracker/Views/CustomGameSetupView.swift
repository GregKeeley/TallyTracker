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
    
    @State var maxScore: Int = 11
    
    @State var servesPerRotation: Int = 3
    
    @State var matchLimit: Int = 1 {
        didSet {
            print(matchLimit)
        }
    }
    
    @State var team1Color = Color.red
    
    @State var team2Color = Color.blue
    
    @State var singlesModeSelected = true
    
    
    // MARK: - Body
    var body: some View {
        ScrollView {
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
                        if maxScore > 10 {
                            maxScore -= 1
                        }
                    } label: {
                        Text("-")
                            .font(.system(size: 32, weight: .regular))
                    }
                    Text(maxScore.description)
                        .font(.system(size: 32, weight: .regular))
                    Button {
                        // Increment set points, no maximum set.
                        maxScore += 1
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
                    ColorPicker("", selection: $team1Color)
                        .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                        .padding(.leading)
                    // TODO: Replace these text strings with text fields to allow for changing of the  names.
                    Text(" 1")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.leading)
                    Spacer()
                    ColorPicker("", selection: $team2Color)
                        .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                        .padding(.leading)
                    Text(" 2")
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
                        if matchLimit > 1 {
                            matchLimit -= 1
                        }
                    } label: {
                        Text("-")
                            .font(.system(size: 32, weight: .regular))
                    }
                    Text(matchLimit.description)
                        .font(.system(size: 32, weight: .regular))
                    Button {
                        // Increment games per match, mo maxiumum.
                        matchLimit += 1
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
                            Image(systemName: "x.square")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                        } else {
                            Image(systemName: "square")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                        }
                    }
                    Text("Singles")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    Button {
                        singlesModeSelected.toggle()
                    } label: {
                        if !singlesModeSelected {
                            Image(systemName: "x.square")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                        } else {
                            Image(systemName: "square")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                        }
                    }
                    Text("Doubles")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }
                Spacer(minLength: 32)
                // Begin game button.
                HStack {
                    Spacer()
                    NavigationLink {
                        if servesPerRotation > 2 {
                            GameTallyView(viewModel: GameViewModel(serveLimit: servesPerRotation,
                                                                   scoreLimit: maxScore,
                                                                   team1Color: team1Color,
                                                                   team2Color: team2Color,
                                                                   isTeam1Serving: true,
                                                                   matchLimit: matchLimit))
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
            }
        }
    }
    
}


//MARK: - Previews
struct CustomGameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGameSetupView()
    }
}
