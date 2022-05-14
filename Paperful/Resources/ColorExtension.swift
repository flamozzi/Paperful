//
//  ColorExtension.swift
//  Paperful
//
//  Created by Tony on 2022/05/14.
//

import Foundation
import SwiftUI

extension Color {
    static let backgroundColor = Color("backgroundColor")
}

extension UIColor {
    class var backgroundColor: UIColor? { return UIColor(named: "backgroundColor")}
}
