//
//  DetailView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/28.
//

import SwiftUI

struct DetailLoadingView: View {
  @Binding var coin: CoinModel?
  
  var body: some View {
    ZStack {
      if let coin = coin {
          DetailView(coin: coin)
      }
    } //: ZSTACK
  }
}

struct DetailView: View {
  @StateObject var vm: DetailViewModel
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
  }

  var body: some View {
    Text("hi")
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(coin: dev.coin)
  }
}
