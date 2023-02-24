//
//  TallyButtonViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class TallyButtonViewModel: ObservableObject {
    
    /// Represents the team color.
    @Published var teamColor: Color
    /// Represents the name of the team.
    @Published var teamName: String
    /// Tracks the score of the team.
    @Published var teamScore: Int
    /// Used to determine if this view model belongs to team 1.
    @Published var isTeamOne: Bool
    ///
    @Published var scoreLimit: Int
    ///
    @Published var serveLimit: Int
    ///
    @Published var matchLimit: Int
    /// Tracks the current serve. Starts on 1; The first serve.
    @Published var serveCount: Int
    ///
    @Published var isCurrentlyServing: Bool
    ///
    @Published var teamWins: [Color]
    
    @Published var gameOver: Bool
    
    init(color: Color, teamName: String, teamScore: Int, isTeamOne: Bool, serveLimit: Int, isCurrentlyServing: Bool, serveCount: Int, scoreLimit: Int, teamWins: [Color], gameOver: Bool, matchLimit: Int) {
        self.teamColor = color
        self.teamName = teamName
        self.teamScore = teamScore
        self.isTeamOne = isTeamOne
        self.serveLimit = serveLimit
        self.isCurrentlyServing = isCurrentlyServing
        self.serveCount = serveCount
        self.scoreLimit = scoreLimit
        self.teamWins = teamWins
        self.gameOver = gameOver
        self.matchLimit = matchLimit
    }
    
    func increaseScore() {
        // Increase score.
        if teamScore < scoreLimit {
            teamScore += 1
            incrementServe()
        } else if teamScore >= scoreLimit {
            // Add the teams color to the team wins array; Reset Score.
            incrementTeamWin()
            teamScore = 0
        }
    }
    func incrementServe() {
        if isCurrentlyServing {
            if serveCount < serveLimit {
                serveCount += 1
            } else {
                serveCount = 1
                isCurrentlyServing.toggle()
            }
        }
    }
    
    func incrementTeamWin() {
        // Get index of the previous winner, if any.
        if let indexOfPreviousWinner = teamWins.lastIndex(where: { $0 != .gray }) {
//            // Check the total wins for the team is less than half of the match limit.
            let totalTeamWins = teamWins.filter { $0 == teamColor }
//            print("totalTeamWins: \(totalTeamWins)")
//            print((totalTeamWins.count / matchLimit))
            if (Double(totalTeamWins.count / matchLimit) < 0.5) {
                teamWins[indexOfPreviousWinner + 1] = teamColor
            } else {
                print("I win.")
                gameOver = true
            }
        } else {
            teamWins[0] = teamColor
        }
    }
    
    func decrementTeamScoreAndServe() {
        if serveCount > 1 {
            serveCount -= 1
        } else {
            isCurrentlyServing = false
        }
        if teamScore > 0 {
            teamScore -= 1
        }
    }
    
}
