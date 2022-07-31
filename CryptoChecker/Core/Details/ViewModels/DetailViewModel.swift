//
//  DetailViewModel.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/29.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
  @Published var overviewStatistics: [StatisticModel] = []
  @Published var additionalStatistics: [StatisticModel] = []
  @Published var coinDescription: String? = nil
  @Published var redditUrl: String? = nil
  @Published var websiteUrl: String? = nil
  
  @Published var coin: CoinModel
  private let coinDetailService: CoinDetailDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coin = coin
    self.coinDetailService = CoinDetailDataService(coin: coin)
    self.addSubscribers()
  }
  
  private func addSubscribers() {
    coinDetailService.$coinDetail
      .combineLatest($coin)
      .map(mapDataToStatistics)
      .sink { [weak self] (returnedData) in
        self?.overviewStatistics = returnedData.overview
        self?.additionalStatistics = returnedData.additional
      }
      .store(in: &cancellables)
    
    coinDetailService.$coinDetail
      .sink { [weak self] (returnedCoinDetails) in
        self?.coinDescription = returnedCoinDetails?.readableDescription
        self?.redditUrl = returnedCoinDetails?.links?.subredditURL
        self?.websiteUrl = returnedCoinDetails?.links?.homepage?.first
      }
      .store(in: &cancellables)
  }
  
  private func mapDataToStatistics(details: CoinDetailModel?, coin: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
    // Overview
    let price = coin.currentPrice.asCurrencyWith6Decimals()
    let pricePercentChange = coin.priceChangePercentage24H
    let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
    
    let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
    let marketCapPercentChange = coin.marketCapChangePercentage24H
    let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
    
    let rank = "\(coin.rank)"
    let rankStat = StatisticModel(title: "Rank", value: rank)
    
    let volumn = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
    let volumnStat = StatisticModel(title: "Volumn", value: volumn)
    
    let overviewList: [StatisticModel] = [
      priceStat,
      marketCapStat,
      rankStat,
      volumnStat
    ]
    
    let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
    let highStat = StatisticModel(title: "24 High", value: high)
    
    let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
    let lowStat = StatisticModel(title: "24 Low", value: low)
    
    let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
    let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
    
    let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
    let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
    
    let blockTime = details?.blockTimeInMinutes ?? 0
    let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
    let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
    
    let hashing = details?.hashingAlgorithm ?? "n/a"
    let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
    
    let additionalArray: [StatisticModel] = [
      highStat,
      lowStat,
      priceChangeStat,
      marketCapChangeStat,
      blockStat,
      hashingStat
    ]
    
    return (overviewList, additionalArray)
  }
}
