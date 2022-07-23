//
//  MarketDataService.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import Foundation
import Combine

class MarketDataService {
  @Published var marketData: MarketDataModel? = nil
  var marketdataSubscription: AnyCancellable?
  
  init() {
    getData()
  }
  
  private func getData() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
      return
    }
    
    marketdataSubscription = NetworkManager.download(url: url)
      .decode(type: GlobalData.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
        self?.marketData = returnedGlobalData.data
        self?.marketdataSubscription?.cancel()
      })
  }
}
