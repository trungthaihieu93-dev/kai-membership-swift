//
//  CalendarPickerModel.swift
//  KAI Membership
//
//  Created by DAKiet on 23/03/2021.
//

import Foundation

enum CalendarDataError: Error {
    case metadataGeneration
}

struct  Day  {
    let date: Date
    let number: String
    let isSelected: Bool
    let isWithinDisplayedMonth: Bool
}

struct MonthMetadata {
    let numberOfDays: Int
    let firstDay: Date
    let firstDayWeekday: Int
}
