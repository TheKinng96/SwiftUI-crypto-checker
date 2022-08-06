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
  private let apiUrl = URL(string: "https://www.coingecko.com/")!
  private let courseUrl = URL(string: "https://www.youtube.com/watch?v=TTYKL6CfbSs&list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu&index=1")!
  
  var body: some View {
    NavigationView {
      List {
        aboutApp
        geckoSection
        devSection
        applicationSection
      } //: LIST
      .font(.headline)
      .tint(Color.blue)
      .listStyle(GroupedListStyle())
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          XMarkButton(dismiss: dismiss)
        }
      }
      .navigationTitle("Settings")
    } //: NAVIGATION
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}

extension SettingView {
  private var aboutApp: some View {
    Section(content: {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      
      Text("""
      This app is originally designed and coded by @SwiftfulThinking.
      Code partially updated by Gen.
      """)
      .font(.callout)
      .fontWeight(.medium)
      .foregroundColor(.theme.accent)
      .multilineTextAlignment(.leading)
      }
      .padding(.vertical)
      
      Link("Course Link 📚", destination: courseUrl)
      Link("Github Link 🤖", destination: githubUrl)
    }, header: {
      Text("About App")
    })
  }

  private var geckoSection: some View {
    Section(content: {
      VStack(alignment: .leading) {
        Image("coingecko")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      
      Text("Crypto data comes from coin gecko free API.")
      .font(.callout)
      .fontWeight(.medium)
      .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
      
      Link("Visit Coin Gecko", destination: apiUrl)
    }, header: {
      Text("API info")
    })
  }
  
  private var devSection: some View {
    Section(content: {
      VStack(alignment: .leading) {
        Image("gen")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      
      Text("This app was developed by Gen. ")
      .font(.callout)
      .fontWeight(.medium)
      .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
      
      Link("Visit Github", destination: githubUrl)
    }, header: {
      Text("Developer")
    })
  }
  
  private var applicationSection: some View {
    Section(content: {
      Link("Term of Service", destination: githubUrl)
      Link("Privacy Policy", destination: githubUrl)
      Link("Company Website", destination: githubUrl)
      Link("Learn More", destination: githubUrl)
    }, header: {
      Text("Application")
    })
  }
}
