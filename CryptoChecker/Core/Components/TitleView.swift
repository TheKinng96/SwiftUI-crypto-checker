//
//  TitleView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/29.
//

import SwiftUI

struct TitleView: View {
  let title: String

  var body: some View {
    Text(title)
      .bold()
      .frame(maxWidth: .infinity, alignment: .leading)
      .foregroundColor(.theme.accent)
      .font(.title)
  }
}

struct TitleView_Previews: PreviewProvider {
  static var previews: some View {
    TitleView(title: "Overview")
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
