//
//  CoinDetailDataService.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/29.
//

import Foundation
import Combine

class CoinDetailDataService {
  @Published var coinDetail: CoinDetailModel? = nil
  var coinDetailSubscription: AnyCancellable?
  let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinDetail()
  }
  
  func getCoinDetail() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
      return
    }
    
    coinDetailSubscription = NetworkManager.download(url: url)
      .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetail) in
        self?.coinDetail = returnedCoinDetail
        self?.coinDetailSubscription?.cancel()
      })
  }
}
