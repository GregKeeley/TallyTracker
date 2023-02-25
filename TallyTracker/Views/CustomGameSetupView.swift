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
    /// Stores the maximum score for the game
    // TODO: Establish a sensible range.
    /// Range: 11 - ?
    @State var maxScore: Int = 11
    /// Amount of time a player serves in a row before the alternate player serves.
    @State var servesPerRotation: Int = 3
    /// The amount of matches in a game. eg: 5 (Best of 5)
    @State var matchLimit: Int = 1
    /// The color used to represent team 1.
    @State var team1Color = Color.red
    /// The color used to represent team 2.
    @State var team2Color = Color.blue
    /// Determines if singles mode is selected. Set to 'true' for singles; 'false' for doubles.
    //    @State var singlesModeSelected = true
    @State var automaticallySwitchSides = false
    @State var isEditingTeam1Name: Bool = false
    @State var isEditingTeam2Name: Bool = false
    @State var team1Name: String = "Team 1"
    @State var team2Name: String = "Team 2"
    
    // MARK: - Body
    var body: some View {
        
        ScrollView {
            ZStack {
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
                    .padding(.top)
                    .padding(.horizontal)
                    HStack {
                        Text("Auto Switch")
                            .lineLimit(2)
                            .minimumScaleFactor(0.4)
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                        Button {
                            automaticallySwitchSides.toggle()
                        } label: {
                            Image(systemName: automaticallySwitchSides ? "x.square" : "square")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width * 0.07, height: UIScreen.main.bounds.size.width * 0.07)
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.horizontal)
                    
                    // Team color
                    HStack {
                        Spacer()
                        VStack {
                            ColorPicker("", selection: $team1Color)
                                .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                            Button {
                                isEditingTeam1Name = true
                            } label: {
                                Text(team1Name)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(team1Color)
                                Image(systemName: "pencil")
                                    .resizable()
                                    .foregroundColor(team1Color)
                                    .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                            }
                            Spacer(minLength: 24)
                            ColorPicker("", selection: $team2Color)
                                .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                            Button {
                                isEditingTeam2Name = true
                            } label: {
                                HStack {
                                    Text(team2Name)
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(team2Color)
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .foregroundColor(team2Color)
                                        .frame(width: UIScreen.main.bounds.size.width * 0.075, height: UIScreen.main.bounds.size.width * 0.075)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }
                    
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
                    // ICEBOX Feature.
                    //                HStack {
                    //                    Spacer()
                    //                    Button {
                    //                        singlesModeSelected.toggle()
                    //                    } label: {
                    //                        if singlesModeSelected {
                    //                            Image(systemName: "x.square")
                    //                                .resizable()
                    //                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                    //                        } else {
                    //                            Image(systemName: "square")
                    //                                .resizable()
                    //                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                    //                        }
                    //                    }
                    //                    Text("Singles")
                    //                        .font(.system(size: 24, weight: .bold))
                    //                    Spacer()
                    //                    Button {
                    //                        singlesModeSelected.toggle()
                    //                    } label: {
                    //                        if !singlesModeSelected {
                    //                            Image(systemName: "x.square")
                    //                                .resizable()
                    //                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                    //                        } else {
                    //                            Image(systemName: "square")
                    //                                .resizable()
                    //                                .frame(width: UIScreen.main.bounds.size.width * 0.05, height: UIScreen.main.bounds.size.width * 0.05)
                    //                        }
                    //                    }
                    //                    Text("Doubles")
                    //                        .font(.system(size: 24, weight: .bold))
                    //                    Spacer()
                    //                }
                    .padding()
                    Spacer()
                    // Begin game button.
                    HStack {
                        Spacer()
                        NavigationLink {
                            let viewModel = GameViewModel(serveLimit: servesPerRotation,
                                                          scoreLimit: maxScore,
                                                          team1Color: team1Color,
                                                          team2Color: team2Color,
                                                          isTeam1Serving: true,
                                                          matchLimit: matchLimit,
                                                          automaticallySwitchSides: automaticallySwitchSides,
                                                          team1Name: team1Name,
                                                          team2Name: team2Name)
                            GameTallyView(viewModel: viewModel)
                        } label: {
                            Text("BEGIN")
                                .font(.system(size: 48, weight: .bold))
                                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.5)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .background(colorScheme == .dark ? .black : .white)
                                .ignoresSafeArea()
                                .colorInvert()
                        }
                        Spacer()
                    }
                    .padding()
                }
                if isEditingTeam1Name {
                    EditNameView(isViewShown: $isEditingTeam1Name, teamName: $team1Name)
                } else if isEditingTeam2Name {
                    EditNameView(isViewShown: $isEditingTeam2Name, teamName: $team2Name)
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
