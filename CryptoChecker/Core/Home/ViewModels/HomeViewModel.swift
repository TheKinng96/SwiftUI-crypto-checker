//
//  HomeViewModel.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/20.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var statistics: [StatisticModel] = [
    StatisticModel(title: "title", value: "value", percentageChange: 1),
    StatisticModel(title: "title", value: "value"),
    StatisticModel(title: "title", value: "value"),
    StatisticModel(title: "title", value: "value", percentageChange: -1)
  ]
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  
  @Published var searchText: String = ""
  
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(dataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
      return coins
    }
    
    let loweredcasedText = text.lowercased()
    
    return coins.filter { (coin) -> Bool in
      return coin.name.lowercased().contains(loweredcasedText) ||
        coin.id.lowercased().contains(loweredcasedText) ||
        coin.symbol.lowercased().contains(loweredcasedText)
    }
  }
}
