//
//  HomeViewModel.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/20.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  @Published var statistics: [StatisticModel] = []
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var isLoading: Bool = false
  @Published var searchText: String = ""
  
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  func addSubscribers() {
    $searchText
      .combineLatest(coinDataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] (returnedCoins) in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map(mapAllCoinsToPortfolioCoin)
      .sink { [weak self] (returnedCoins) in
        self?.portfolioCoins  = returnedCoins
      }
      .store(in: &cancellables)
    
    marketDataService.$marketData
      .combineLatest($portfolioCoins)
      .map(mapGlobalMarketData)
      .sink { [weak self] (returnedStats) in
        self?.statistics = returnedStats
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataService.getData()
    HapticManager.notification(type: .success)
    print("updated!!!")
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
  
  private func mapAllCoinsToPortfolioCoin(allCoins: [CoinModel], portfolioCoins: [PortfolioEntity]) -> [CoinModel] {
    allCoins
      .compactMap { (coin) -> CoinModel? in
        guard let entity = portfolioCoins.first(where: { $0.coinId == coin.id }) else {
          return nil
        }
        return coin.updateHoldings(amount: entity.amount)
      }
  }
  
  private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
    var stats: [StatisticModel] = []
    
    guard let data = marketDataModel else {
      return stats
    }
    
    let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volumn = StatisticModel(title: "24h Volumn", value: data.volumn)
    let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    
    let portfolioValue =
      portfolioCoins
        .map({$0.currentHoldingsValue})
        .reduce(0, +)
    
    let previousValue =
      portfolioCoins
        .map { (coin) -> Double in
          let currentValue = coin.currentHoldingsValue
          let precentChange = (coin.priceChangePercentage24H ?? 0) / 100
          let previousValue = currentValue / (1 + precentChange)
          return previousValue
        }
        .reduce(0, +)
    
    let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
    
    let portfolio = StatisticModel(
      title: "Portfolio Value",
      value: portfolioValue.asCurrencyWith2Decimals(),
      percentageChange: percentageChange
    )
    
    stats.append(contentsOf: [
      marketCap,
      volumn,
      btcDominance,
      portfolio
    ])
    return stats
  }
}
