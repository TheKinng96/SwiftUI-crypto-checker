//
//  String.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/31.
//

import Foundation

extension String {
  var removingHTMLOccurances: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
