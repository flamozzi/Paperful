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
    static let borderColor = Color("borderColor")
    static let loginButtonColor = Color("loginButtonColor")
    static let lightGreyColor = Color("lightGreyColor")
}

extension UIColor {
    class var backgroundColor: UIColor? { return UIColor(named: "backgroundColor")}
    class var borderColor: UIColor? { return UIColor(named: "borderColor")}
    class var loginButtonColor: UIColor? { return UIColor(named: "loginButtonColor")}
    class var lightGreyColor: UIColor? { return UIColor(named: "lightGreyColor")}
}
