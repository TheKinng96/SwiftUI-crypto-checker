//
//  Color.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import Foundation
import SwiftUI

extension Color {
  static let theme = ColorTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}
