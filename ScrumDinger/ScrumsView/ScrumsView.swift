//
//  ScrumsView.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI

struct ScrumsView: View {
  let scrums: DailyScrumList
  var body: some View {
    List {
      ForEach(scrums) { scrum in
        NavigationLink(destination: ScrumView(scrum: scrum)) {
          DailyScrumCardView(dailyScrum: scrum)
        }.listRowBackground(scrum.color)
      }
    }
    .navigationTitle("Daily Scrums")
    .navigationBarItems(trailing: Button(action: {}) {
      Image(systemName: "plus")
    })
  }
}

struct ScrumsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrumsView(scrums: DailyScrum.data)
    }
  }
}
