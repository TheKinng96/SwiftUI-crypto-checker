//
//  SearchBarView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import SwiftUI

struct SearchBarView: View {
  @Binding var searchText: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(searchText.isEmpty ? .theme.secondaryText : .theme.accent)
      
      TextField("Search by name or symbol...", text: $searchText)
        .disableAutocorrection(true)
        .foregroundColor(.theme.accent)
        .overlay(
          Image(systemName: "xmark.circle.fill")
            .padding()
            .offset(x: 10)
            .foregroundColor(.theme.accent)
            .opacity(searchText.isEmpty ? 0.0 : 1.0)
            .onTapGesture {
              UIApplication.shared.endEditing()
              searchText = ""
            }
          , alignment: .trailing
        )
    } //: HSTACK
    .font(.headline)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.theme.background)
        .shadow(color: .theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
    )
    .padding(.horizontal)
    .padding(.vertical, 8)
  }
}

struct SearchBarView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
      SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.light)
        .previewLayout(.sizeThatFits)
    }
  }
}
