//
//  DailyScrumCardView.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI

struct DailyScrumCardView: View {
  let dailyScrum: DailyScrum
  var body: some View {
    Group {
      VStack(alignment: .leading) {
        Text(dailyScrum.title)
          .font(.headline)
        
        Spacer()
        HStack {
          Label(dailyScrum.attendees.count.description, systemImage: "person.3")
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text("Attendees"))
            .accessibilityValue(Text(dailyScrum.attendees.count.description))
          Spacer()
          Label(dailyScrum.lengthInMinutes.description, systemImage: "clock")
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text("Meeting length"))
            .accessibilityValue(Text("\(dailyScrum.lengthInMinutes) minutes"))
        }.font(.caption)
      }
      .padding()
    }.background(dailyScrum.color)
  }
}

struct DailyScrumCardView_Previews: PreviewProvider {
  static var previews: some View {
    DailyScrumCardView(dailyScrum: DailyScrum.data[0])
      .previewLayout(.fixed(width: 400, height: 60))
  }
}
