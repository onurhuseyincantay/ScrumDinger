//
//  DailyScrum.swift
//  ScrumDinger
//
//  Created by Onur Cantay on 14/08/2021.
//

import SwiftUI

typealias DailyScrumList = [DailyScrum]

struct DailyScrum: Identifiable {
  let id: UUID = .init()
  var title: String
  var attendees: AttendeeList
  var lengthInMinutes: Int
  var color: Color
}

typealias AttendeeList = [Attendee]
struct Attendee: Identifiable {
  let id: UUID = .init()
  let name: String
}

extension DailyScrum {
  static var data: [DailyScrum] {
    [
      DailyScrum(title: "Design", attendees: [Attendee(name: "Cathy"), Attendee(name: "Daisy"), Attendee(name: "Simon"), Attendee(name: "Jonathan")], lengthInMinutes: 10, color: Color("Design")),
      DailyScrum(title: "App Dev", attendees: [Attendee(name: "Katie"), Attendee(name: "Gray"), Attendee(name: "Euna"), Attendee(name: "Luis"), Attendee(name: "Darla")], lengthInMinutes: 5, color: Color("App Dev")),
      DailyScrum(title: "Web Dev", attendees: [Attendee(name: "Chella"), Attendee(name: "Chris"), Attendee(name: "Christina"), Attendee(name: "Eden"), Attendee(name: "Karla"), Attendee(name: "Lindsey"), Attendee(name: "Aga"), Attendee(name: "Chad"), Attendee(name: "Jenn"), Attendee(name: "Sarah")], lengthInMinutes: 1, color: Color("Web Dev"))
    ]
  }
}

extension DailyScrum {
  
  struct Data: Equatable, Identifiable {
    let id: UUID
    var title: String = ""
    var attendees: AttendeeList = []
    var lengthInMinutes: Double = 5.0
    var color: Color = .accentColor
    
    static func == (lhs: DailyScrum.Data, rhs: DailyScrum.Data) -> Bool {
      lhs.id == rhs.id
    }
  }
  
  var data: Data {
    return Data(id: id, title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), color: color)
  }
}
