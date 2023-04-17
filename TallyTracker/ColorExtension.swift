//
//  ColorExtension.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/17/23.
//

import SwiftUI

extension Color {
    // MARK: Methods
    /// Inputs a hex value of 6 characters and outputs a Color object, if the hex is incorrect it will default to a clear color.
    /// - Parameter hex: A 6 character hex including the `#`, ex: #FEFEFE.
    /// - Returns: A SwiftUI Color object.
    static public func fromHex(hex: String) -> Self {
        // Creates 3 values that will be used to decipher which colors have what values.
        let red, green, blue: CGFloat
        // Checks if the string starts with a `#`.
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...]).uppercased()
            // Checks if the string has at least 6 characters after the hash.
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    // Red
                    red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    // Green
                    green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    // Blue
                    blue = CGFloat(hexNumber & 0x0000ff) / 255
                    let inputedColor = Self(red: Double(red), green: Double(green), blue: Double(blue), opacity: 1.0)
                    return inputedColor
                }
            }
        }
//        return AppColors.clearColor
        return Color.clear
    }
    
}
