//
//  SettingView.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/08/04.
//

import SwiftUI

struct SettingView: View {
  @Environment(\.dismiss) var dismiss
  private let githubUrl = URL(string: "https://github.com/TheKinng96")!
  private let corekaraUrl = URL(string: "https://corekara.co.jp/memberp/gen/")!
  
  var body: some View {
    NavigationView {
      List {
        Section(content: {
          Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }, header: {
          Text("Header")
        })
        .listStyle(GroupedListStyle())
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            XMarkButton(dismiss: dismiss)
          }
        }
      } //: LIST
    } //: NAVIGATION
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}
