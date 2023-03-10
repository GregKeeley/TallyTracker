//
//  EditNameView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/25/23.
//

import SwiftUI

struct EditNameView: View {
    // MARK: - Variables/Properties
    /// Determines if this view is currently being displayed to the user.
    /// Set to 'true' to make the view appear.
    /// Set to 'false' to hide the view.
    @Binding var isViewShown: Bool
    /// String representing the name of the team used to call this view.
    @Binding var teamName: String
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            // Opaque background to obscure view that will be behind this.
            Color.black
                .opacity(0.5)
                .ignoresSafeArea(.all, edges: .vertical)
            ZStack {
                GeometryReader { viewGeometry in
                    // Alert style popup begins here.
                    VStack() {
                        VStack {
                            TextField("Enter Team Name", text: $teamName)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .foregroundColor(Color.gray.opacity(0.2))
                                        .frame(width: (viewGeometry.size.width * 0.95), height: (viewGeometry.size.height * 0.25)))
                        }
                        GeometryReader { buttonGeometry in
                            Spacer()
                            Divider()
                            HStack {
                                // Cancel button to dismiss the view.
                                Spacer()
                                Button(action: {
                                    // Hides the view if false.
                                    self.isViewShown = false
                                }) {
                                    Text("Cancel")
                                        .font(Font.custom("SF Pro", size: 16))
                                }
                                Spacer()
                                Divider()
                                    .frame(height: buttonGeometry.size.height, alignment: .center)
                                // Confirmation button to set the buzz length.
                                Spacer()
                                Button(action: {
                                    teamName = teamName
                                    self.isViewShown = false
                                }) {
                                    Text("Confirm")
                                        .font(Font.custom("SF Pro", size: 16))
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .frame(width: (UIScreen.main.bounds.width * 0.80), height: (UIScreen.main.bounds.height * 0.15))
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 20)
            }
        }
    }
    
}



//MARK: - Previews
struct EditNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditNameView(isViewShown: .constant(true), teamName: .constant("Greg"))
            .previewLayout(.sizeThatFits)
    }
}
