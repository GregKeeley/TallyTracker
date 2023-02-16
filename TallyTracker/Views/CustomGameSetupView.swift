//
//  CustomGameSetupView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/16/23.
//

import SwiftUI

struct CustomGameSetupView: View {
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("House Rules")
                .underline()
                .padding()
            
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
            
        }
    }
    
}


//MARK: - Previews
struct CustomGameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGameSetupView()
    }
}
