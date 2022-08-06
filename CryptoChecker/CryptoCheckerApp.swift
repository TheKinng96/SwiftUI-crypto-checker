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
  @State private var showLaunchView: Bool = true
  
  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
  }
  
  var body: some Scene {
    WindowGroup {
      ZStack {
        NavigationView {
          HomeView()
            .navigationBarHidden(true)
        } //: NAVIGATION VIEW
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(vm)
        
        ZStack {
          if showLaunchView {
            LaunchView(showLaunchView: $showLaunchView)
              .transition(.move(edge: .leading))
          }
        } //: ZSTACK
        .zIndex(2)
      } //: ZSTACK
    }
  }
}
