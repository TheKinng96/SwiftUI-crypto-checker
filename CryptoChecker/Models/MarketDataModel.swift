//
//  MarketDataModel.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import Foundation

// API data
/**
  URL: https://api.coingecko.com/api/v3/global
 
  Response:
 {
   "data": {
     "active_cryptocurrencies": 13418,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 531,
     "total_market_cap": {
       "btc": 47648229.96040016
     },
     "total_volume": {
       "btc": 4525670.121414545,
     },
     "market_cap_percentage": {
       "btc": 40.08682382509134,
     },
     "market_cap_change_percentage_24h_usd": 0.2290597642263176,
     "updated_at": 1658554544
   }
 }
 */

struct GlobalData: Codable {
  let data: MarketDataModel?
}

struct MarketDataModel: Codable {
  let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
  let marketCapChangePercentage24HUsd: Double
  
  enum CodingKeys: String, CodingKey {
    case totalMarketCap = "total_market_cap"
    case totalVolume = "total_volume"
    case marketCapPercentage = "market_cap_percentage"
    case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
  }
  
  var marketCap: String {
    if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }
  
  var volumn: String {
    if let item = totalVolume.first(where: { $0.key == "usd"}) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }
  
  var btcDominance: String {
    if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
      return item.value.asPercentString()
    }
    return ""
  }
}


