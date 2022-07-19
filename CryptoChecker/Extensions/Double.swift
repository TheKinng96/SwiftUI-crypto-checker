//
//  Double.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import Foundation

extension Double {
  /// Convert a double into a Currency with 2  decimal
  ///  ```
  ///  1234.56 -> $1,234.56
  ///  ```
  private var currencyFormatter2: NumberFormatter {
    let formatter = NumberFormatter()
    
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
//    formatter.locale = .current
//    formatter.currencyCode = "usd"
//    formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    return formatter
  }
  
  /// Convert a double into a Currency as a String with 2 to 6 decimal
  ///  ```
  ///  1234.56 -> "$1,234.56"
  ///  ```
  func asCurrencyWith2Decimals() -> String {
    let number = NSNumber(value: self)
    return currencyFormatter2.string(from: number) ?? "$0.00"
  }

  /// Convert a double into a Currency with 2 to 6 decimal
  ///  ```
  ///  1234.56 -> $1,234.56
  ///  12.3456 -> $12.3456
  ///  0.123456 -> $0.123456
  ///  0.1234567 -> $0.123457
  ///  ```
  private var currencyFormatter2to6: NumberFormatter {
    let formatter = NumberFormatter()
    
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
//    formatter.locale = .current
//    formatter.currencyCode = "usd"
//    formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 6
    formatter.minimumFractionDigits = 2
    
    return formatter
  }
  
  /// Convert a double into a Currency as a String with 2 to 6 decimal
  ///  ```
  ///  1234.56 -> "$1,234.56"
  ///  12.3456 -> "$12.3456"
  ///  0.123456 -> "$0.123456"
  ///  0.1234567 -> "$0.123457"
  ///  ```
  func asCurrencyWith6Decimals() -> String {
    let number = NSNumber(value: self)
    return currencyFormatter2to6.string(from: number) ?? "$0.00"
  }
  
  /// Convert a double into a String representation
  ///  ```
  ///  12.3456 -> "12.34"
  ///  ```
  func asNumberString() -> String {
    return String(format: "%.2f", self)
  }
  
  /// Convert a double into a String representation with percent symbol
  ///  ```
  ///  12.3456 -> "12.34%"
  ///  ```
  func asPercentString() -> String {
    return asNumberString() + "%"
  }
}
