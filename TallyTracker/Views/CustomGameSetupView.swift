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
                            .minimumScaleFactor(0.4)
                            .padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 27)
                            .stroke(lineWidth: 4)
                            .frame(width: geo.size.width * 0.872)
                            .background(AppColors.standardWhite.cornerRadius(27))
                        
                        VStack {
                            // SET POINTS
                            HStack {
                                Text("Set Points")
                                    .font(Font.custom(poppinsSemiBold, size: 40))
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                    .padding()
                                Spacer()
                                AdjustableCounterView(currentValue: 1,
                                                      maxValue: 25,
                                                      minValue: 3)
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            
                            // # of serves before rotation
                            HStack {
                                Text("Serves per rotation")
                                    .font(Font.custom(poppinsSemiBold, size: 40))
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(2)
                                    .padding(.horizontal)
                                Spacer()
                                AdjustableCounterView(currentValue: 1,
                                                      maxValue: 5,
                                                      minValue: 2)
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            
                            // Games Per Match
                            HStack {
                                Text("Game Per Match")
                                    .font(Font.custom(poppinsSemiBold, size: 40))
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(2)
                                    .padding(.horizontal)
                                Spacer()
                                AdjustableCounterView(currentValue: 1,
                                                      maxValue: 10,
                                                      minValue: 1)
                            }
                            .padding()
                            
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
                            Spacer()
                        }
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
