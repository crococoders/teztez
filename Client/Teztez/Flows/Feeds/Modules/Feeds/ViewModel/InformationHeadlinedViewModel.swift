//
//  InformationHeadlinedViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation
import Models

struct InformationHeadlinedViewModel {
    let title: String
    let metaTitle: String
    var imageURL: String
    var weekDay: String?
    var date: String?

    init(date: Date, model: HeadlinedInformationBlock) {
        title = model.title
        metaTitle = model.metaTitle.uppercased()
        imageURL = model.coverImage
        weekDay = getWeekDay(from: date)
        self.date = getDateString(from: date).uppercased()
    }

    private func getWeekDay(from date: Date) -> String {
        guard !Calendar.current.isDateInToday(date) else {
            return "TODAY"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    private func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        let isDateinToday = Calendar.current.isDateInToday(date)
        dateFormatter.dateFormat = isDateinToday ? "EEEE d MMM" : "d MMM"
        return dateFormatter.string(from: date)
    }
}
