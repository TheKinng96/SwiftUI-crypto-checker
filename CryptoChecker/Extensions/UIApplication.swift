//
//  UIApplication.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import Foundation
import SwiftUI

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
