//
//  CoinLogoView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/24.
//

import SwiftUI

struct CoinLogoView: View {
  let coin: CoinModel
  
  var body: some View {
    VStack {
      CoinImageView(coin: coin)
        .frame(width: 50, height: 50)
      
      Text(coin.symbol.uppercased())
        .font(.headline)
        .foregroundColor(.theme.accent)
        .lineLimit(1)
        .minimumScaleFactor(0.5)
      
      Text(coin.name)
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .minimumScaleFactor(0.5)
    } //: VSTACK
  }
}

struct CoinLogoView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CoinLogoView(coin: dev.coin)
        .previewLayout(.sizeThatFits)
      .padding()
      CoinLogoView(coin: dev.coin)
        .previewLayout(.sizeThatFits)
        .padding()
        .preferredColorScheme(.dark)
    }
  }
}
