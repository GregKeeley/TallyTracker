//
//  TallyButtonViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class TallyButtonViewModel: ObservableObject {
    @Published var color: Color
    @Published var teamName: String
    @Published var teamScore: Int
    @Published var isTeamOne: Bool
    
    init(color: Color, teamName: String, teamScore: Int, isTeamOne: Bool) {
        self.color = color
        self.teamName = teamName
        self.teamScore = teamScore
        self.isTeamOne = isTeamOne
    }
    
}
