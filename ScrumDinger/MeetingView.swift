//
//  MeetingView.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI

struct MeetingView: View {
  var body: some View {
    VStack {
      ProgressView(value: 5, total: 15)
      HStack {
        VStack(alignment: .leading) {
          Text("Second Elapsed")
            .font(.caption)
          Label("300", systemImage: "hourglass.bottomhalf.fill")
        }
        Spacer()
        VStack(alignment: .trailing) {
          Text("Second Remaining")
            .font(.caption)
          Label("600", systemImage: "hourglass.tophalf.fill")
        }
      }
      .accessibilityElement(children: .ignore)
      .accessibility(label: Text("Time Remaining"))
      .accessibility(value: Text("10 Minutes"))
      
      Circle()
        .strokeBorder(lineWidth: 24, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
      
      HStack {
        Text("Speaker 1 of 3")
        Spacer()
        
        Button(action: {}) {
            Image(systemName: "forward.fill")
        }
        .accessibility(label: Text("Next Speaker"))
      }
    }
    .padding()
  }
}

struct MeetingView_Previews: PreviewProvider {
  static var previews: some View {
    MeetingView()
  }
}
