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
    // TODO: Extract relevant team properties and create a model to support those support those properties.
    /// Store the names for the first team.
    @Published var firstTeamName: String
    /// Stores the name for the second team.
    @Published var secondTeamName: String
    /// Store the color used to represent team one.
    @Published var firstTeamColor: Color
    /// Stores the color used to represent for team two.
    @Published var secondTeamColor: Color
    /// Determines if teams should automatically rotate sides at the end of a match. When set to 'true' the position of team 1 and
    /// team 2 will switch their respectives sides (landscape only) when a match is complete. This helps represent the physical position
    /// of the players in relation to the table and score board.
    // TODO: Extract relevant properties for a single game/match and create a model.
    @Published var teamsAutomaticallySwitchSides: Bool = false
    /// Determines if the teams have switched sides or not. Used with 'automaticallySwitchSides' to determine the layout for each
    /// individual match. If auto rotate is enabled by the user, this stores the layout.
    /// Set to 'false' for default layout, set to 'true' to switch team positions.
    @Published var teamsSwitchedSides: Bool = false
    /// Tracks the score of the first team.
    @Published var firstTeamScore: Int = 0
    /// Track the score of the second team.
    @Published var secondTeamScore: Int = 0
    /// Tracks the current count of the serve. This will increment every time the score of the game
    /// increments until the 'serveLimit' is reached. Once this happens, the serve count will reset to '1' and repeat.
    /// This represents the score a single team needs to achieve before that team is declared the winner.
    @Published var scoreLimit: Int
    /// Default is set to '1' aka the first serve.
    @Published var serveCount: Int = 1
    /// The maximum amount of consecutive serves a team before which player is serving needs to rotate.
    @Published var serveLimit: Int
    /// This represents the max amount of serves that occur before the teams switch who serves the ball.
    @Published var isFirstTeamServing: Bool
    /// This represent the amount of matches a team needs to win before they are declared winner of the game.
    @Published var matchLimit: Int
    /// Tracks when an individual match is complete. A game is comprised of individual matches.
    @Published var matchComplete: Bool = false
    /// Tracks when the end of the has been reached. Set to 'true' once a player has won the majority of matches in a game.
    @Published var gameOver: Bool = false
    /// Array of 'Color' that tracks team wins. When first initialized, this array is comprised of 'Color.gray' objects in the same
    /// amount as 'matchLimit'. When a team wins a match, their color replaces one of the 'Color.gray' objects to represent a win.
    // TODO: Refactor this to work as an array of bool representing total wins for the first team. ie: [true, false, true] = 3 wins for the first team.
    // TODO: Note that the array should be empty until either the first or second team has won match. Append 'true' if the first team wins, 'false' if the second team wins.
    // TODO: The count of this array can no longer be used to represent the match limit either.
    @Published var totalTeamWinColors: [Color]
    // TODO: Move these two variables to their own View Model for the main menu.
    /// When to set to 'true', the user will start a new game with default rules.
    @Published var navigateToStandardGame: Bool = false
    /// When to set to 'true', the user will be navigated to the custome game view setup view.
    @Published var navigateToCustomGame: Bool = false
    /// When to set to 'true' the current game will be cancelled, as the user is navigated back to the previos view they originated from.
    @Published var presentAlert: Bool = false
    
    // MARK: - Init
    init(serveLimit: Int, scoreLimit: Int, firstTeamColor: Color, secondTeamColor: Color, firstTeamName: String, secondTeamName: String, firstTeamIsServing: Bool, matchLimit: Int, teamsAutomaticallySwitchSides: Bool) {
        self.serveLimit = serveLimit
        self.scoreLimit = scoreLimit
        self.firstTeamColor = firstTeamColor
        self.secondTeamColor = secondTeamColor
        self.firstTeamName = firstTeamName
        self.secondTeamName = secondTeamName
        self.isFirstTeamServing = firstTeamIsServing
        self.matchLimit = matchLimit
        self.totalTeamWinColors = Array(repeating: .gray, count: matchLimit)
        self.teamsAutomaticallySwitchSides = teamsAutomaticallySwitchSides
    }
    
    // MARK: - Functions
    /// Resets the entire game.
    func resetGame() {
        totalTeamWinColors = Array(repeating: .gray, count: self.matchLimit)
        gameOver = false
        startNewMatch()
    }
    /// Resets scores to start a new match.
    func startNewMatch() {
        matchComplete = false
        //        isFirstTeamServing.toggle()
        serveCount = 1
        firstTeamScore = 0
        secondTeamScore = 0
    }
    
    /// Increases a teams score depending on the caller.
    /// - Parameter isTeamOne: Set to 'true' when team one is calling the function to increase
    func increaseScore(isFirstTeam: Bool) {
        if isFirstTeam {
            if firstTeamScore < scoreLimit  {
                firstTeamScore += 1
                if firstTeamScore >= scoreLimit {
                    incrementTeamWin(isFirstTeam: true)
                }
                incrementServe()
            }
        } else {
            if secondTeamScore < scoreLimit {
                secondTeamScore += 1
                if secondTeamScore >= scoreLimit {
                    incrementTeamWin(isFirstTeam: false)
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
            isFirstTeamServing.toggle()
        }
    }
    
    /// Determines if the current amount of wins a team has achieved is more than half of the match limit.
    /// - Parameter teamWins: Total amount matches a team has won in this game.
    /// - Parameter matchLimit: Maximum number of matches played per game.
    /// - Returns: 'true' if the team wins account for more than 50% of the match limit set by the user.
    func didTeamWinGame(totalTeamWins: Double, matchLimit: Double) -> Bool {
        return (totalTeamWins / matchLimit) > 0.51
    }
    
    /// When a team has been determined as having won a match, this method is called to increment their wins.
    /// - Parameter isTeamOne: Set to 'true' when called by the first team; 'false' when called by the second team to add the appropriate color to the 'teamWins' array.
    func incrementTeamWin(isFirstTeam: Bool) {
        // Match is complete, switch sides.
        matchComplete = true
        teamsSwitchedSides.toggle()
        // Get index of the previous winner, if available.
        if let indexOfPreviousWinner = totalTeamWinColors.lastIndex(where: { $0 != .gray }) {
            if isFirstTeam {
                // Using the index of the previous winner, set the next index to the winners color.
                totalTeamWinColors[indexOfPreviousWinner + 1] = firstTeamColor
                // Get the total wins for the team and check if the team won. If they won, set 'gameOver' to 'true', otherwise start a new match.
                let totalTeamWinsCount = totalTeamWinColors.filter { $0 == firstTeamColor }
                if didTeamWinGame(totalTeamWins: Double(totalTeamWinsCount.count), matchLimit: Double(self.matchLimit)) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            } else {
                // Same as above, for the second team.
                totalTeamWinColors[indexOfPreviousWinner + 1] = secondTeamColor
                let totalTeamWinsCount = totalTeamWinColors.filter { $0 == secondTeamColor }
                if didTeamWinGame(totalTeamWins: Double(totalTeamWinsCount.count), matchLimit: Double(self.matchLimit)) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            }
        } else {
            // No previous winner has been found, set the first index in the array to the winning teams color.
            if isFirstTeam {
                totalTeamWinColors[0] = firstTeamColor
                // Check if this team won (if they have 1 match per game, this would be a win), and set 'gameOver' to 'true', otherwise start a new match.
                let firstTeamWinCount: Double = Double(totalTeamWinColors.filter { $0 == firstTeamColor }.count)
                if didTeamWinGame(totalTeamWins: firstTeamWinCount, matchLimit: Double(self.matchLimit)) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            } else {
                totalTeamWinColors[0] = secondTeamColor
                let secondTeamWinCount: Double = Double(totalTeamWinColors.filter { $0 == secondTeamColor }.count)
                if didTeamWinGame(totalTeamWins: secondTeamWinCount, matchLimit: Double(self.matchLimit)) {
                    gameOver = true
                } else {
                    startNewMatch()
                }
            }
        }
    }
    
    /// Decrements the calling teams score by one. Used when a the score has been incremented incorrectly by the user, to correct the score.
    /// - Parameter isFirstTeam: Set to 'true' when the first team is calling this function to increase their score; 'false' to increase the second teams score.
    func decrementTeamScoreAndServe(isFirstTeam: Bool) {
        if isFirstTeam {
            if firstTeamScore > 0 {
                firstTeamScore -= 1
            }
        } else {
            if secondTeamScore > 0 {
                secondTeamScore -= 1
            }
        }
        if serveCount > 1 {
            serveCount -= 1
        } else {
            serveCount = serveLimit
            isFirstTeamServing.toggle()
        }
    }
    
}
