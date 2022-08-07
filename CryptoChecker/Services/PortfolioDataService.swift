//
//  PortfolioDataService.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/25.
//

import Foundation
import CoreData
import UIKit

class PortfolioDataService {
  private let container: NSPersistentContainer
  private let containerName: String = "PortfolioContainer"
  private let entityName: String = "PortfolioEntity"
  
  @Published var savedEntities: [PortfolioEntity] = []
  
  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading Core Data: \(error)")
      }
    }
    
    self.getPortfolio()
  }
  
  // MARK: Public section
  func updatePortfolio(coin: CoinModel, amount: Double) {
    if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
      if amount > 0 {
        update(entity: entity, amount: amount)
      } else {
        delete(entity: entity)
      }
    } else {
      add(coin: coin, amount: amount)
    }
  }
  
  func removePortfolio(coin: CoinModel) {
    if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
      delete(entity: entity)
    }
  }
  
  // MARK: Private section
  private func getPortfolio() {
    let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
    
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error when fetching entity: \(error)")
    }
  }
  
  private func add(coin: CoinModel, amount: Double) {
    let entity = PortfolioEntity(context: container.viewContext)
    entity.coinId = coin.id
    entity.amount = amount
  
    applyChanges()
  }
  
  private func update(entity: PortfolioEntity, amount: Double) {
    entity.amount = amount
    applyChanges()
  }
  
  private func delete(entity: PortfolioEntity) {
    container.viewContext.delete(entity)
    applyChanges()
  }
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch let error {
      print("Error while saving entity: \(error)")
    }
  }
  
  private func applyChanges() {
    save()
    getPortfolio()
  }
}
