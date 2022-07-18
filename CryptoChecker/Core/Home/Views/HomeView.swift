//
//  HomeView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import SwiftUI

struct HomeView: View {
  @State private var showPortfolio: Bool = false
  
  var body: some View {
    ZStack {
      // Background layer
      Color.theme.background
        .ignoresSafeArea(.all)
      
      // Content layer
      VStack {
        homeHeader
        
        Spacer(minLength: 0)
      } //: VSTACK
    } //: ZSTACK
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView()
    }
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
}
