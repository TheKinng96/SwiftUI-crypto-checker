//
//  CoinRowView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import SwiftUI

struct CoinRowView: View {
  let coin: CoinModel
  
  var body: some View {
    HStack(spacing: 0) {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .frame(minWidth: 30)
      
      Circle()
        .frame(width: 30, height: 30)
      
      Text("\(coin.symbol)")
        .padding(.leading, 6)
        .font(.headline)
        .foregroundColor(.theme.accent)
      
      Spacer()
      
      VStack(alignment: .trailing) {
        Text(coin.currentPrice.asCurrencyWith6Decimals())
          .foregroundColor(.theme.accent)
          .fontWeight(.bold)
        
        Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
          .foregroundColor(
            (coin.priceChangePercentage24H ?? 0) >= 0 ?
              .theme.green :
              .theme.red
          )
        
      } //: VSTACK
    } //: HSTACK
  }
}

struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    CoinRowView(coin: dev.coin)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
