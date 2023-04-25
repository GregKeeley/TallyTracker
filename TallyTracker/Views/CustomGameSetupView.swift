//
//  CustomGameSetupView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/16/23.
//

import SwiftUI

struct CustomGameSetupView: View {
    // MARK: - Variables/Properties
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
    /// Determines if each match in the game should end with the players "switching sides", both IRL and in the UI.
    /// Set to 'true' to have the TallyButtonViews automatically rearrange themselves at the end of each match.
    /// Set to 'false' to keep the button views staticly placed.
    @State var automaticallySwitchSides = false
    /// Set to 'true' to display the view for editing the first teams name.
    @State var isEditingTeam1Name: Bool = false
    /// Set to 'true' to display the view for editing the second teams name.
    @State var isEditingTeam2Name: Bool = false
    /// String representing the first teams name.
    @State var team1Name: String = "Team 1"
    /// String representing the second teams name.
    @State var team2Name: String = "Team 2"
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AppColors.primaryGreen
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image("BackButton")
                        Spacer()
                    }
                    .frame(width: geo.size.width * 0.872)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 27)
                            .stroke(lineWidth: 4)
                            .frame(width: geo.size.width * 0.872, height: geo.size.height * 0.08)
                            .background(AppColors.primaryLightGreen.cornerRadius(27))
                            .padding()
                        // House Rules
                        Text("Create Rules")
                            .font(Font.custom(AppFonts.poppinsSemiBold, size: 40))
                            .padding()
                    }
                    
                    // SET POINTS
                    HStack {
                        Text("Set Points")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                        AdjustableCounterView(currentValue: 1,
                                              maxValue: 25,
                                              minValue: 3)
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
                    Spacer()
                    // Begin game button.
                    HStack {
                        Spacer()
                        NavigationLink {
                            let viewModel = GameViewModel(serveLimit: servesPerRotation,
                                                          scoreLimit: maxScore,
                                                          firstTeamColor: team1Color,
                                                          secondTeamColor: team2Color,
                                                          firstTeamName: team1Name,
                                                          secondTeamName: team2Name,
                                                          firstTeamIsServing: true,
                                                          matchLimit: matchLimit,
                                                          teamsAutomaticallySwitchSides: automaticallySwitchSides)
                            GameTallyView(viewModel: viewModel)
                        } label: {
                            Text("BEGIN")
                                .font(.system(size: 48, weight: .bold))
                                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.5)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .background(colorScheme == .dark ? .black : .white)
                                .cornerRadius(8.0)
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
