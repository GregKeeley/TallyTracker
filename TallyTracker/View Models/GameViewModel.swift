//
//  GameViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    @Environment(\.colorScheme) var colorScheme
    
    /// Tracks the score of team 1.
    @Published var team1Score: Int = 0
    /// Track the score of team 2.
    @Published var team2Score: Int = 0
    /// Store the names for team 1.
    @Published var team1Name: String = ""
    /// Stores the name for team 2.
    @Published var team2Name: String = ""
    /// Store the names for team 1.
    @Published var team1Color: Color
    /// Stores the name for team 2.
    @Published var team2Color: Color
    /// Tracks the current count of the serve. This will increment every time the score of the game
    /// increments until the 'serveLimit' is reached. Once this happens, the serve count will reset to zero and repeat.
    /// Default is set to 1, as it can never be the count '0'.
    @Published var serveCount: Int = 1
    /// This represents the max amount of serves that occur before the teams switch who serves the ball.
    @Published var isTeam1Serving: Bool
    ///
    @Published var serveLimit: Int
    /// This represents the score a single team needs to achieve before that team is declared the winner.
    @Published var scoreLimit: Int
    /// This represent the amount of matches a team needs to win before they are declared winner.
    @Published var matchLimit: Int
    /// Tracks when the end of the has been reached.
    @Published var gameOver: Bool = false
    /// Tracks when an individual match is complete.
    @Published var matchComplete: Bool = false
    ///
    @Published var teamWins: [Color]
    /// When to set to 'true', the user will start a game with standard rules.
    @Published var navigateToStandardGame: Bool = false
    /// When to set to 'true', the user will be navigated to the custome game view setup view.
    @Published var navigateToCustomGame: Bool = false
    @Published var automaticallySwitchSides: Bool = false
    @Published var hasSwitchedSides: Bool = false
    
    init(serveLimit: Int, scoreLimit: Int, team1Color: Color, team2Color: Color, isTeam1Serving: Bool, matchLimit: Int, automaticallySwitchSides: Bool) {
        self.serveLimit = serveLimit
        self.scoreLimit = scoreLimit
        self.team1Color = team1Color
        self.team2Color = team2Color
        self.isTeam1Serving = isTeam1Serving
        self.matchLimit = matchLimit
        self.teamWins = Array(repeating: .gray, count: matchLimit)
        self.automaticallySwitchSides = automaticallySwitchSides
    }
    
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
    
    func increaseScore(isTeamOne: Bool) {
        // Increase score.
        if isTeamOne {
            if team1Score < scoreLimit  {
                team1Score += 1
                incrementServe()
            } else {
                // Add the teams color to the team wins array; Reset Score.
                incrementTeamWin(isTeamOne: true)
            }
        } else {
            if team2Score < scoreLimit {
                team2Score += 1
                incrementServe()
            } else {
                // Add the teams color to the team wins array; Reset Score.
                incrementTeamWin(isTeamOne: false)
            }
        }
    }
    
    func incrementServe() {
        if serveCount < serveLimit {
            serveCount += 1
        } else {
            serveCount = 1
            isTeam1Serving.toggle()
        }
    }
    
    func didTeamwinMatch(teamWins: Int) -> Bool {
        print("\(teamWins) / \(matchLimit) = \(Double(teamWins) / Double(matchLimit))")
        return (Double(teamWins) / Double(matchLimit) > 0.51)
    }
    
    func incrementTeamWin(isTeamOne: Bool) {
        // Check for who won the last match and get the index, if available.
        matchComplete = true
        hasSwitchedSides.toggle()
        if let indexOfPreviousWinner = teamWins.lastIndex(where: { $0 != .gray }) {
            if isTeamOne {
                teamWins[indexOfPreviousWinner + 1] = team1Color
                let totalTeamWins = teamWins.filter { $0 == team1Color }
                if didTeamwinMatch(teamWins: totalTeamWins.count) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            } else {
                teamWins[indexOfPreviousWinner + 1] = team2Color
                let totalTeamWins = teamWins.filter { $0 == team2Color }
                if didTeamwinMatch(teamWins: totalTeamWins.count) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            }
        } else {
            if isTeamOne {
                teamWins[0] = team1Color
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
