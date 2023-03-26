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
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                //                    .foregroundColor(.red)
                    .offset(x: 0.5, y: 0.5)
                HStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2.5)
                            .foregroundColor(.blue)
                            .offset(x: 0.5, y: 0.5)
                        
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: geo.size.height, height: geo.size.height)
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
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(.red)
                            .offset(x: 0.5, y: 0.5)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: geo.size.height, height: geo.size.height)
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



//MARK: - Previews
struct ChangeValueButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeValueButtonView(currentValue: 0)
        //            .previewLayout(.sizeThatFits)
            .frame(width: 80, height: 20)
    }
}
