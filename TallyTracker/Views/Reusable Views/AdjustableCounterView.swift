//
//  AdjustableCounterView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/19/23.
//

import SwiftUI

struct AdjustableCounterView: View {
    /// The value displayed to the used. This value is used to establish a parameter when setting up a custom game.
    @State var currentValue: Int
    /// The upper bound of the range for the value.
    @State var maxValue: Int
    /// Lower bound of the range for the value.
    @State var minValue: Int
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center) {
                Button {
                    if currentValue > minValue {
                        currentValue -= 1
                    }
                } label: {
                    SimpleCircleButtonView(imageName: "minus.circle", color: AppColors.neutralGray1)
                        .frame(width: UIScreen.main.bounds.height * 0.049, height: UIScreen.main.bounds.height * 0.049)
                }
                .foregroundColor(.black)
                Spacer()
                Text("\(currentValue)")
                    .font(Font.custom(AppFonts.poppinsSemiBold, size: 40))
                    .minimumScaleFactor(0.4)
                Spacer()
                Button {
                    if currentValue < maxValue {
                        currentValue += 1
                    }
                } label: {
                    SimpleCircleButtonView(imageName: "plus.circle", color: AppColors.primaryLightGreen)
                        .frame(width: UIScreen.main.bounds.height * 0.049, height: UIScreen.main.bounds.height * 0.049)
                }
                .foregroundColor(.black)
            }
            .frame(width: UIScreen.main.bounds.width * 0.38, height: UIScreen.main.bounds.height * 0.049)
            Capsule()
                .stroke(lineWidth: 4.0)
                .frame(width: UIScreen.main.bounds.width * 0.37, height: UIScreen.main.bounds.height * 0.049)
        }
        .padding(.horizontal)
    }
}



//MARK: - Previews
struct AdjustableCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustableCounterView(currentValue: 1,
                              maxValue: 10,
                              minValue: 0)
        .previewLayout(.sizeThatFits)
    }
}
