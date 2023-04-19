//
//  AdjustableCounterView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/19/23.
//

import SwiftUI

struct AdjustableCounterView: View {
    
    var body: some View {
        ZStack {
            Image("Pill shape")
            HStack {
                Image("minus")
//                Spacer()
                Image("add")
            }
        }
    }
}



//MARK: - Previews
struct AdjustableCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustableCounterView()
            .previewLayout(.sizeThatFits)
    }
}
