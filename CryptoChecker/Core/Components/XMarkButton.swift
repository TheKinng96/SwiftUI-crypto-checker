//
//  XMarkButton.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import SwiftUI

struct XMarkButton: View {
  let dismiss: DismissAction
  
  var body: some View {
    Button (action: {
      dismiss()
    }, label: {
      Image(systemName: "xmark")
        .font(.headline)
    })
  }
}
