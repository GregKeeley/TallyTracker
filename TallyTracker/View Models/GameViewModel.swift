//
//  GameViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class GameViewModel: ObservableObject {
    // MARK: - Properties and Variables
    /// Used to determine the color scheme of the users device for layout/color purposes.
    @Environment(\.colorScheme) var colorScheme
    /// Tracks the score of team 1.
    @Published var team1Score: Int = 0
    /// Track the score of team 2.
    @Published var team2Score: Int = 0
    /// Store the names for team 1.
    @Published var team1Name: String
    /// Stores the name for team 2.
    @Published var team2Name: String
    /// Store the color used to represent team 1.
    @Published var team1Color: Color
    /// Stores the color used to represent for team 2.
    @Published var team2Color: Color
    /// Tracks the current count of the serve. This will increment every time the score of the game
    /// increments until the 'serveLimit' is reached. Once this happens, the serve count will reset to '1' and repeat.
    /// Default is set to 1 (the first serve), as it can never be the count '0'.
    @Published var serveCount: Int = 1
    /// This represents the max amount of serves that occur before the teams switch who serves the ball.
    @Published var isTeam1Serving: Bool
    /// The maximum amount of consecutive serves a team before which player is serving needs to rotate.
    @Published var serveLimit: Int
    /// This represents the score a single team needs to achieve before that team is declared the winner.
    @Published var scoreLimit: Int
    /// This represent the amount of matches a team needs to win before they are declared winner of the game.
    @Published var matchLimit: Int
    /// Tracks when the end of the has been reached. Set to 'true' once a player has won the majority of matches in a game.
    @Published var gameOver: Bool = false
    /// Tracks when an individual match is complete. A game is comprised of individual matches.
    @Published var matchComplete: Bool = false
    /// Array of 'Color' that tracks team wins. When first initialized, this array is comprised of 'Color.gray' objects in the same
    /// amount as 'matchLimit'. When a team wins a match, their color replaces one of the 'Color.gray' objects to represent a win.
    @Published var teamWins: [Color]
    /// When to set to 'true', the user will start a new game with default rules.
    @Published var navigateToStandardGame: Bool = false
    /// When to set to 'true', the user will be navigated to the custome game view setup view.
    @Published var navigateToCustomGame: Bool = false
    /// Determines if teams should automatically rotate sides at the end of a match. When set to 'true' the position of team 1 and
    /// team 2 will switch their respectives sides (landscape only) when a match is complete. This helps represent the physical position
    /// of the players in relation to the table and score board.
    @Published var automaticallySwitchSides: Bool = false
    /// Determines if the teams have switched sides or not. Used with 'automaticallySwitchSides' to determine the layout for each
    /// individual match. If auto rotate is enabled by the user, this stores the layout.
    /// Set to 'false' for default layout, set to 'true' to switch team positions.
    @Published var hasSwitchedSides: Bool = false
    
    // MARK: - Init
    init(serveLimit: Int, scoreLimit: Int, team1Color: Color, team2Color: Color, isTeam1Serving: Bool, matchLimit: Int, automaticallySwitchSides: Bool, team1Name: String, team2Name: String) {
        self.serveLimit = serveLimit
        self.scoreLimit = scoreLimit
        self.team1Color = team1Color
        self.team2Color = team2Color
        self.isTeam1Serving = isTeam1Serving
        self.matchLimit = matchLimit
        self.teamWins = Array(repeating: .gray, count: matchLimit)
        self.automaticallySwitchSides = automaticallySwitchSides
        self.team1Name = team1Name
        self.team2Name = team2Name
    }
    
    // MARK: - Functions
    /// Resets the entire game.
    func resetGame() {
        teamWins = Array(repeating: .gray, count: self.matchLimit)
        gameOver = false
        startNewMatch()
    }
    /// Resets scores to start a new match.
    func startNewMatch() {
        matchComplete = false
        serveCount = 1
        team1Score = 0
        team2Score = 0
    }
    
    /// Increases a teams score depending on the caller.
    /// - Parameter isTeamOne: Set to 'true' when team one is calling the function to increase
    func increaseScore(isTeamOne: Bool) {
        if isTeamOne {
            if team1Score < scoreLimit  {
                team1Score += 1
                if team1Score >= scoreLimit {
                    incrementTeamWin(isTeamOne: true)
                }
                incrementServe()
            }
        } else {
            if team2Score < scoreLimit {
                team2Score += 1
                if team2Score >= scoreLimit {
                    incrementTeamWin(isTeamOne: false)
                }
                incrementServe()
            }
        }
    }
    
    
    /// Increments the serve count, if it is below the serve limit for the match. If it is equal or greater to the serve limit, the team that is serving is toggled and the serve count resets to '1' (the first serve).
    func incrementServe() {
        if serveCount < serveLimit {
            serveCount += 1
        } else {
            serveCount = 1
            isTeam1Serving.toggle()
        }
    }
    
    /// Checks if the current amount of wins a player has achieved is the "best of" the matches limit (matchLimit).
    /// - Parameter teamWins: Integer describing the amount of wins a team has accomplished.
    /// - Returns: 'true' if the team wins account for more than 50% of the match limit set by the user.
    func didTeamwinMatch(teamWins: Int) -> Bool {
        print("\(teamWins) / \(matchLimit) = \(Double(teamWins) / Double(matchLimit))")
        return (Double(teamWins) / Double(matchLimit) > 0.51)
    }
    
    /// When a team has been determined as having won a match, this method is called to increment their wins.
    /// - Parameter isTeamOne: Set to 'true' when called by team 1, to add the appropriate color to the 'teamWins' array.
    func incrementTeamWin(isTeamOne: Bool) {
        // Match is complete, switch sides.
        matchComplete = true
        hasSwitchedSides.toggle()
        // Get index of the previous winner, if available.
        if let indexOfPreviousWinner = teamWins.lastIndex(where: { $0 != .gray }) {
            if isTeamOne {
                // Using the index of the previous winner, we can set the newest winners color in the array.
                teamWins[indexOfPreviousWinner + 1] = team1Color
                // Get the total wins for the team and check if the team won. If they won, set 'gameOver' to 'true', otherwise start a new match.
                let totalTeamWins = teamWins.filter { $0 == team1Color }
                if didTeamwinMatch(teamWins: totalTeamWins.count) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            } else {
                // Same as above, for team two.
                teamWins[indexOfPreviousWinner + 1] = team2Color
                let totalTeamWins = teamWins.filter { $0 == team2Color }
                if didTeamwinMatch(teamWins: totalTeamWins.count) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            }
        } else {
            // No previous winner has been found, set the first index in the array to the winning teams color.
            if isTeamOne {
                teamWins[0] = team1Color
                // Check if this team won (if they have 1 match per game, this would be a win), and set 'gameOver' to 'true', otherwise start a new match.
                if didTeamwinMatch(teamWins: (teamWins.filter { $0 == team1Color }).count ) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            } else {
                teamWins[0] = team2Color
                if didTeamwinMatch(teamWins: (teamWins.filter { $0 == team2Color }).count ) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            }
        }
    }
    
    /// Decrements the calling teams score by one. Used when a button has been accidentally tapped to correct the score.
    /// - Parameter isTeamOne: Set to 'true' when team one is calling the function to increase
    func decrementTeamScoreAndServe(isTeamOne: Bool) {
        if isTeamOne {
            if team1Score > 0 {
                team1Score -= 1
            }
        } else {
            if team2Score > 0 {
                team2Score -= 1
            }
        }
        if serveCount > 1 {
            serveCount -= 1
        } else {
            serveCount = serveLimit
            isTeam1Serving.toggle()
        }
    }
    
}
