//
//  DetailViewModel.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/29.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
  private let coinDetailService: CoinDetailDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coinDetailService = CoinDetailDataService(coin: coin)
    self.addSubscribers()
  }
  
  private func addSubscribers() {
    coinDetailService.$coinDetail
      .sink { (returnedData) in
        print(returnedData)
      }
      .store(in: &cancellables)
  }
}
