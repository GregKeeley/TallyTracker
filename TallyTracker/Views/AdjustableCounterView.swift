//
//  AdjustableCounterView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/19/23.
//

import SwiftUI

struct AdjustableCounterView: View {
    
    @Binding var currentValue: Int
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(lineWidth: 4.0)
                .frame(width: 127.5, height: 40)
            HStack {
                // TODO: The plus and minus images need to be buttons.
                Image(systemName: "minus.circle")
                    .resizable()
                    .background(AppColors.neutralGray1)
                    .clipShape(Circle())
                    .frame(width: 42.5, height: 42.5)
                Spacer()
                Text("\(currentValue)")
                Spacer()
                Image(systemName: "plus.circle")
                    .resizable()
                    .background(AppColors.primaryGreen)
                    .clipShape(Circle())
                    .frame(width: 42.5, height: 42.5)
            }
            .frame(width: 130, height: 40)
        }
    }
}



//MARK: - Previews
struct AdjustableCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustableCounterView(currentValue: .constant(0))
        //            .previewLayout(.sizeThatFits)
    }
}
