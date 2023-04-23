//
//  AdjustableCounterView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/19/23.
//

import SwiftUI

struct AdjustableCounterView: View {
    
    @State var currentValue: Int
    @Binding var maxValue: Int
    @Binding var minValue: Int
    var body: some View {
        ZStack {
            HStack {
                Button {
                    if currentValue > minValue {
                        currentValue -= 1
                    }
                } label: {
                    
                    ZStack {
                        Circle()
                            .foregroundColor(AppColors.neutralGray2)
                            .frame(width: 40, height: 40)
                        Image(systemName: "minus.circle")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 42.5, height: 42.5)
                    }
                }
                .foregroundColor(.black)
                Spacer()
                Text("\(currentValue)")
                Spacer()
                Button {
                    if currentValue < maxValue {
                        currentValue += 1
                    }
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(AppColors.primaryGreen)
                            .frame(width: 40, height: 40)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 42.5, height: 42.5)
                    }
                }
                .foregroundColor(.black)
            }
            .frame(width: 130, height: 40)
            Capsule()
                .stroke(lineWidth: 4.0)
                .frame(width: 127.5, height: 40)
        }
    }
}



//MARK: - Previews
struct AdjustableCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustableCounterView(currentValue: 1,
                              maxValue: .constant(10),
                              minValue: .constant(0))
        .previewLayout(.sizeThatFits)
    }
}
