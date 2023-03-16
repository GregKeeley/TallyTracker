//
//  ChangeValueButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/15/23.
//

import SwiftUI

struct ChangeValueButtonView: View {
    
    @State var currentValue: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                HStack {
                    ZStack {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                    }
                    .onTapGesture {
                        currentValue -= 1
                    }
                    Spacer()
                    Text("\(currentValue)")
                        .foregroundColor(.red)
                    Spacer()
                    ZStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.red)
                    }
                    .onTapGesture {
                        currentValue += 1
                    }
                }
            }
        }
    }
}

struct ChangeValueButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeValueButtonView(currentValue: 0)
            .previewLayout(.sizeThatFits)
            .frame(width: 80, height: 20)
    }
}
