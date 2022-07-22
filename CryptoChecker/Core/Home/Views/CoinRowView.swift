//
//  CoinRowView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import SwiftUI

struct CoinRowView: View {
  let coin: CoinModel
  let showHoldingColumn: Bool
  
  var body: some View {
    HStack(spacing: 0) {
      leftColumn
      
      Spacer()
      
      if showHoldingColumn {
        centerColumn
      }
      
      rightColumn
    } //: HSTACK
    .font(.subheadline)
  }
}

struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CoinRowView(coin: dev.coin, showHoldingColumn: true)
        .previewLayout(.sizeThatFits)
      .padding()
      CoinRowView(coin: dev.coin, showHoldingColumn: true)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
}

extension CoinRowView {
  private var leftColumn: some View {
    HStack(spacing: 0) {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .frame(minWidth: 30)
      
      CoinImageView(coin: coin)
        .frame(width: 30, height: 30)
      
      Text("\(coin.symbol)")
        .padding(.leading, 6)
        .font(.headline)
        .foregroundColor(.theme.accent)
    } //: HSTACK
  }
  
  private var centerColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
      Text((coin.currentHoldings ?? 0).asNumberString())
    }
    .foregroundColor(.theme.accent)
  }
  
  private var rightColumn: some View {
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
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}
