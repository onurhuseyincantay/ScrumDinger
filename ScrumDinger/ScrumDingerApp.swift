//
//  ScrumDingerApp.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI

@main
struct ScrumDingerApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        ScrumsView(scrums: DailyScrum.data)
      }
    }
  }
}
