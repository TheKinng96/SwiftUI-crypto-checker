//
//  PortfolioView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import SwiftUI

struct PortfolioView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject private var vm: HomeViewModel
  @State private var selectedCoin: CoinModel? = nil
  @State private var quantityText: String = ""
  @State private var showCheckMark: Bool = false

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          SearchBarView(searchText: $vm.searchText)
          coinLogoList
          
          if selectedCoin != nil {
            portfolioInpuSection
          }
        } //: VSTACK
      } //：SCROLL
      .background(
        Color.theme.background
          .ignoresSafeArea()
      )
      .navigationTitle("Edit Portfolio")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          XMarkButton(dismiss: dismiss)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          saveButton
        }
      }
      .onChange(of: vm.searchText) { value in
        if value == "" {
          removeSelectedCoin()
        }
      }
    } //: NAVIGATION
  }
}

struct PortfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PortfolioView()
      .environmentObject(dev.homeVM)
  }
}

extension PortfolioView {
  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
          CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .background(
              RoundedRectangle(cornerRadius: 10)
                .stroke(
                  selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                  , lineWidth: 1
                )
            )
            .onTapGesture {
              UIApplication.shared.endEditing()
              withAnimation(.easeIn) {
                selectedCoin = coin
                updateSelectedCoin(coin: coin)
              }
            }
        } //: FOREACH
      } //: LAZYHSTACK
      .frame(height: 120)
      .padding(.leading)
    } //: SCROLL
  }
  
  private var portfolioInpuSection: some View {
    GroupBox {
      VStack {
        HStack{
          Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
          Spacer()
          Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
        } //: HSTACK
        
        Divider()
        
        HStack {
          Text("Amount in your portfolio:")
          Spacer()
          TextField("Ex 2.0", text: $quantityText)
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
        } //: HSTACK
        
        Divider()
        
        HStack {
          Text("Current value:")
          Spacer()
          Text(getCurrentValue().asCurrencyWith2Decimals())
        } //: HSTACK
      } //: VSTACK
      .padding()
      .font(.headline)
    .animation(.none, value: UUID())
    } //: GROUPBOX
    .padding(.horizontal)
  }
  
  private var saveButton: some View {
    HStack {
      Image(systemName: "checkmark")
        .opacity(showCheckMark ? 1.0 : 0.0)
      
      Button(action: {
        saveButtonPressed()
      }, label: {
        Text("save".uppercased())
      })
      .opacity(
        (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ?
          1.0 :
          0.0
      )
    } //: HSTACK
  }
  
  private func saveButtonPressed() {
    guard
      let coin = selectedCoin,
      let amount = Double(quantityText)
    else {return}
    
    vm.updatePortfolio(coin: coin, amount: amount)
    
    withAnimation(.easeIn) {
      showCheckMark = true
      removeSelectedCoin()
    }
    
    UIApplication.shared.endEditing()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      withAnimation(.easeOut) {
        showCheckMark = false
      }
    }
  }
  
  private func removeSelectedCoin() {
    selectedCoin = nil
    vm.searchText = ""
  }
  
  private func getCurrentValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectedCoin?.currentPrice ?? 0)
    }
    return 0
  }
  
  private func updateSelectedCoin(coin: CoinModel) {
    selectedCoin = coin
    
    if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
      let amount = portfolioCoin.currentHoldings {
      quantityText = "\(amount)"
    } else {
      quantityText = ""
    }
  }
}
