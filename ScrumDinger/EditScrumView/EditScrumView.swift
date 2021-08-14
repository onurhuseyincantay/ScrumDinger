//
//  EditScrumView.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI
import ComposableArchitecture

struct EditViewState: Equatable {
  var scrumData: DailyScrum.Data
  var newAttendee: Attendee?
  
  static func == (lhs: EditViewState, rhs: EditViewState) -> Bool {
    lhs.scrumData.id == rhs.scrumData.id
  }
}

enum EditViewAction: Equatable {
  case changeTitle(_ title: String)
  case changeMeetingDuration(_ lengthInMinutes: Double)
  case changeMeetingColor(_ color: Color)
  case deleteAttendee(offsets: IndexSet)
  case newAttendee(_ name: String)
  case saveAttendee
}

let editScrumReducer: Reducer<EditViewState, EditViewAction, Void> = .init { state, action, _ in
  switch action {
  case let .changeMeetingColor(color):
    state.scrumData.color = color
    
  case let .changeMeetingDuration(duration):
    state.scrumData.lengthInMinutes = duration
    
  case let .changeTitle(title):
    state.scrumData.title = title
    
  case let .deleteAttendee(offsets):
    state.scrumData.attendees.remove(atOffsets: offsets)
    
  case let .newAttendee(name):
    guard !name.isEmpty else {
      state.newAttendee = nil
      return .none
    }
    guard state.newAttendee != nil else {
      state.newAttendee = .init(name: name)
      return .none
    }
    
  case .saveAttendee:
    guard let attendee = state.newAttendee else {
      return .none
    }
    state.scrumData.attendees.append(attendee)
    state.newAttendee = nil
  }
  return .none
}.debug()

struct EditScrumView: View {
  let store: Store<EditViewState, EditViewAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        Section(header: Text("Meeting Info")) {
          TextField("Title",
                    text: viewStore.binding(
                      get: { $0.scrumData.title },
                      send: { .changeTitle($0) }
                    ))
          HStack {
            Slider(value: viewStore.binding(
              get: { $0.scrumData.lengthInMinutes },
              send: { .changeMeetingDuration($0) }
            ), in: 5...30, step: 1.0) {
              Text("Length")
            }
            Spacer()
            Text("\(Int(viewStore.scrumData.lengthInMinutes)) minutes")
          }
        }
        ColorPicker("Color",
                    selection: viewStore.binding(
                      get: { $0.scrumData.color },
                      send: { .changeMeetingColor($0) })
        )
        
        Section(header: Text("Attendees")) {
          ForEach(viewStore.scrumData.attendees) { attendee in
            Text(attendee.name)
            
          }.onDelete { indexSet in
            viewStore.send(.deleteAttendee(offsets: indexSet))
          }
          HStack {
            TextField("New Attendee",
                      text: viewStore.binding(
                        get: { $0.newAttendee?.name ?? "" },
                        send: { .newAttendee($0) })
            )
            Button(action: {
              withAnimation {
                viewStore.send(.saveAttendee)
              }
            }) {
              Image(systemName: "plus.circle.fill")
            }
            .disabled(viewStore.newAttendee == nil)
          }
        }
      }
    }
    .listStyle(InsetGroupedListStyle())
  }
}

struct EditScrumView_Previews: PreviewProvider {
  static var previews: some View {
    EditScrumView(store: Store(initialState: EditViewState(scrumData: DailyScrum.data[0].data), reducer: editScrumReducer, environment: Void()))
  }
}
