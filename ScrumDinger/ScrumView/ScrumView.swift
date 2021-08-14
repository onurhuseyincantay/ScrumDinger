//
//  ScrumView.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI
import ComposableArchitecture

struct ScrumView: View {
  let scrum: DailyScrum
  @State private var isPresented = false
  
  var body: some View {
    List {
      Section(header: Text("Meeting Info")) {
        NavigationLink(destination: MeetingView()) {
          Label("Start Meeting", systemImage: "timer")
            .font(.headline)
            .foregroundColor(.accentColor)
            .accessibilityLabel(Text("Start meeting"))
        }
        HStack {
          Label("Length", systemImage: "clock")
            .accessibilityLabel(Text("meeting Length"))
          Spacer()
          Text("\(scrum.lengthInMinutes) minutes")
        }
        HStack {
          Label("Color", systemImage: "paintpalette")
          Spacer()
          Image(systemName: "checkmark.circle.fill")
            .foregroundColor(scrum.color)
        }
      }
      Section(header: Text("Attendees")) {
        ForEach(scrum.attendees) { attendee in
          
          Label(attendee.name, systemImage: "person")
            .accessibilityLabel(Text("Person"))
            .accessibilityValue(Text(attendee.name))}
      }
    }
    .listStyle(InsetGroupedListStyle())
    .navigationTitle(scrum.title)
    .navigationBarItems(trailing: Button("Edit") {
      isPresented = true
    })
    .fullScreenCover(isPresented: $isPresented) {
      NavigationView {
        EditScrumView(store: Store(initialState: EditViewState(scrumData: DailyScrum.data[0].data), reducer: editScrumReducer, environment: Void()))
          .navigationTitle(scrum.title)
          .navigationBarItems(leading: Button("Cancel") {
            isPresented = false
          }, trailing: Button("Done") {
            isPresented = false
          })
      }
    }
  }
}

struct ScrumView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrumView(scrum: DailyScrum.data[0])
    }
  }
}
