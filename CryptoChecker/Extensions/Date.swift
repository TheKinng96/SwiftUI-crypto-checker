//
//  Date.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/30.
//

import Foundation

extension Date {
  init(coinDataDate: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sss.SSSZ"
    let date = formatter.date(from: coinDataDate) ?? Date()
    self.init(timeInterval: 0, since: date)
  }
  
  private var shortFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  func asShortDateString() -> String {
    return shortFormatter.string(from: self)
  }
}
