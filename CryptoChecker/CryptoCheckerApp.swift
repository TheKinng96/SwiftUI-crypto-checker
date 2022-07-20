//
//  CryptoCheckerApp.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/18.
//

import SwiftUI

@main
struct CryptoCheckerApp: App {
  @StateObject var vm = HomeViewModel()
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      } //: NAVIGATION VIEW
      .environmentObject(vm)
    }
  }
}
