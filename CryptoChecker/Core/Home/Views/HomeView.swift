//
//  HomeView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import SwiftUI

struct HomeView: View {
  @State private var showPortfolio: Bool = false
  @EnvironmentObject private var vm: HomeViewModel
  
  var body: some View {
    ZStack {
      // Background layer
      Color.theme.background
        .ignoresSafeArea(.all)
      
      // Content layer
      VStack {
        homeHeader
        
        listHeader
        
        if !showPortfolio {
          allCoinList
            .transition(.move(edge: .leading))
        } else {
          portfolioList
            .transition(.move(edge: .trailing))
        }
        
        Spacer(minLength: 0)
      } //: VSTACK
    } //: ZSTACK
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
        .navigationBarHidden(true)
    }
    .environmentObject(dev.homeVM)
  }
}

extension HomeView {
  private var homeHeader: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .animation(.none, value: showPortfolio)
        .background(
          CircleButtonAnimationView(animate: $showPortfolio)
        )
      
      Spacer()
      
      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(.theme.accent)
      
      Spacer()
      
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle.degrees(showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    } //: HSTACK
    .padding(.horizontal)
  }
  
  private var allCoinList: some View {
    List {
      ForEach(vm.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var portfolioList: some View {
    List {
      ForEach(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var listHeader: some View {
    HStack {
      Text("Coin")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    .padding(.horizontal)
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
  }
}
