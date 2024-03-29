//
//  ChartView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/30.
//

import SwiftUI

struct ChartView: View {
  private let data: [Double]
  private let minY: Double
  private let maxY: Double
  private let lineColor: Color
  private let startingDate: Date
  private let endingDate: Date
  @State private var percentage: CGFloat = 0
  
  init(coin: CoinModel) {
    data = coin.sparklineIn7D?.price ?? []
    minY = data.max() ?? 0
    maxY = data.min() ?? 0
    
    let priceChange = (data.last ?? 0) - (data.first ?? 0)
    lineColor = priceChange >= 0 ? Color.theme.green : Color.theme.red
    
    endingDate = Date(coinDataDate: coin.lastUpdated ?? "")
    startingDate = endingDate.addingTimeInterval(17*24*60*60)
  }
  
  var body: some View {
    VStack {
      chartView
        .frame(height: 200)
        .background(chartBackground)
        .overlay(chartPriceLabel.padding(.horizontal, 4), alignment: .leading)
      
      chartDateLabel
        .padding(.horizontal, 4)
    } //: VSTACK
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        withAnimation(.linear(duration: 1.5)) {
          percentage = 1
        }
      }
    }
  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
    ChartView(coin: dev.coin)
      .previewLayout(.sizeThatFits)
  }
}

extension ChartView {
  private var chartView: some View {
    GeometryReader { geometry in
      Path { path in
        for index in data.indices {
          let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
          let yAxis = maxY - minY
          let yPosition = (CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
          
          if index == 0 {
            path.move(to: CGPoint(x: xPosition, y: yPosition))
          }
          
          path.addLine(to: CGPoint(x: xPosition, y: yPosition))
        }
      } //: PATH
      .trim(from: 0, to: percentage)
      .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
      .shadow(color: lineColor, radius: 10, x: 0, y: 10)
      .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
      .shadow(color: lineColor.opacity(0.25), radius: 10, x: 0, y: 30)
    } //: GEOMETRY
  }
  
  private var chartBackground: some View {
    VStack {
      Divider()
      Spacer()
      Divider()
      Spacer()
      Divider()
    } //: VSTACK
  }
  
  private var chartPriceLabel: some View {
    VStack {
      Text(maxY.formattedWithAbbreviations())
      Spacer()
      Text((((maxY - minY) / 2) + minY).formattedWithAbbreviations())
      Spacer()
      Text(minY.formattedWithAbbreviations())
    } //: VSTACK
  }
  
  private var chartDateLabel: some View {
    HStack {
      Text(startingDate.asShortDateString())
      Spacer()
      Text(endingDate.asShortDateString())
    } //: HSTACK
  }
}
