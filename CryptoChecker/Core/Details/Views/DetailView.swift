//
//  DetailView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/28.
//

import SwiftUI

struct DetailLoadingView: View {
  @Binding var coin: CoinModel?
  
  var body: some View {
    ZStack {
      if let coin = coin {
          DetailView(coin: coin)
      }
    } //: ZSTACK
  }
}

struct DetailView: View {
  @StateObject var vm: DetailViewModel
  @State private var showFullDescription: Bool = false

  let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  private let spacing: CGFloat = 30
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
  }

  var body: some View {
    ScrollView {
      VStack {
        ChartView(coin: vm.coin)
          .padding(.vertical)

        VStack(spacing: 20) {
          
          TitleView(title: "Overview")
          Divider()
          
          descriptionSection
          
          overviewGrid
          
          TitleView(title: "Additional Details")
          Divider()
          
          addtionalGrid
          
          linkSection
        } //: VSTACK
        .padding()
      } //: VSTACK
    } //: SCROLL
    .background(
      Color.theme.background
        .ignoresSafeArea()
    )
    .navigationTitle(vm.coin.name)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        detailIcon
      }
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DetailView(coin: dev.coin)
    }
  }
}

extension DetailView {
  private var detailIcon: some View {
    HStack {
      Text(vm.coin.symbol.uppercased())
        .font(.headline)
        .foregroundColor(.theme.secondaryText)

      CoinImageView(coin: vm.coin)
        .frame(width: 25, height: 25)
    } //: HSTACK
  }
  
  private var overviewGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: []) {
        ForEach(vm.overviewStatistics) { stat in
          StatisticView(stat: stat)
        }
      }
  }
  
  private var addtionalGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: []) {
        ForEach(vm.additionalStatistics) { stat in
          StatisticView(stat: stat)
        }
      }
  }
  
  private var descriptionSection: some View {
    VStack {
      if let coinDescription = vm.coinDescription,
         !coinDescription.isEmpty {
        VStack(alignment: .leading) {
          Text(coinDescription)
            .lineLimit(showFullDescription ? nil : 3)
            .font(.callout)
            .foregroundColor(.theme.secondaryText)
          
          Button(action: {
            withAnimation(.easeInOut) {
              showFullDescription.toggle()
            }
          }, label: {
            Text(showFullDescription ? "Hide" : "Read More ...")
              .font(.caption)
              .foregroundColor(.blue)
              .fontWeight(.bold)
              .padding(.vertical, 4)
          })
        } //: VSTACK
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    } //: VSTACK
  }
  
  private var linkSection: some View {
    VStack(alignment: .leading, spacing: 10) {
      if let link = vm.websiteUrl,
         let url = URL(string: link) {
        Link("Website", destination: url)
      }
      
      if let redditLink = vm.redditUrl,
         let url = URL(string: redditLink) {
        Link("Reddit", destination: url)
      }
    } //: VSTACK
    .foregroundColor(.blue)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
