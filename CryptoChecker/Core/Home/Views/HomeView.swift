//
//  HomeView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var vm: HomeViewModel
  @State private var showPortfolio: Bool = false
  @State private var showProtfolioView: Bool = false
  
  var body: some View {
    ZStack {
      // Background layer
      Color.theme.background
        .sheet(isPresented: $showProtfolioView, content: {
          PortfolioView()
            .environmentObject(vm)
        })
        .ignoresSafeArea(.all)
      
      // Content layer
      VStack {
        homeHeader
        
        HomeStatsView(showPortfolio: $showPortfolio)
        
        SearchBarView(searchText: $vm.searchText)
        
        listHeader
        
        if !showPortfolio {
          allCoinList
            .transition(.move(edge: .trailing))
        } else {
          portfolioList
            .transition(.move(edge: .leading))
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
        .onTapGesture {
          if showPortfolio {
            showProtfolioView.toggle()
          }
        }
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
    .refreshable {
      vm.reloadData()
    }
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
      HStack {
        Text("Coin")
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
          .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
      }
      .onTapGesture {
        withAnimation(.default) {
          vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
        }
      }

      Spacer()
      if showPortfolio {
        HStack {
          Text("Holdings")
          Image(systemName: "chevron.down")
            .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
            .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
        }
        .onTapGesture {
          withAnimation(.default) {
            vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
          }
        }
      }
      
      HStack {
        Text("Price")
        Image(systemName: "chevron.down")
          .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
          .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
      }
      .onTapGesture {
        withAnimation(.default) {
          vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
        }
      }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
      
      Button(action: {
        withAnimation(.linear(duration: 2.0)) {
          vm.reloadData()
          
        }
      }, label: {
        Image(systemName: "goforward")
      })
      .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
    }
    .padding(.horizontal)
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
  }
}
