//
//  HapticManager.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/26.
//

import Foundation
import SwiftUI

class HapticManager {
  static private let generator = UINotificationFeedbackGenerator()
  
  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
