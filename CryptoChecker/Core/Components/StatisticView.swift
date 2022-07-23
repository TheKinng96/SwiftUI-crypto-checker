//
//  StatisticView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import SwiftUI

struct StatisticView: View {
  let stat: StatisticModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(stat.title)
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
      
      Text(stat.value)
        .font(.headline)
        .foregroundColor(.theme.accent)
      
      HStack(spacing: 4) {
        Image(systemName: "triangle.fill")
          .font(.caption2)
          .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
        
        Text(stat.percentageChange?.asPercentString() ?? "")
          .font(.caption)
          .bold()
      } //: HSTACK
      .foregroundColor((stat.percentageChange ?? 0) >= 0 ? .theme.green : .theme.red)
      .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
    } //: VSTACK
  }
}

struct StatisticView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StatisticView(stat: dev.stat1)
        .preferredColorScheme(.dark)
        .padding()
        .previewLayout(.sizeThatFits)
      StatisticView(stat: dev.stat2)
        .padding()
        .previewLayout(.sizeThatFits)
      StatisticView(stat: dev.stat3)
        .padding()
        .previewLayout(.sizeThatFits)
    }
  }
}
