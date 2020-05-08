//
//  InformationDetailedViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation
import Models

struct InformationDetailedViewModel {
    let title: String
    let metaTitle: String
    let subtitle: String
    var imageURL: String
    var weekDay: String?
    var date: String?

    init(date: Date, model: DetailedInformationBlock) {
        title = model.title
        metaTitle = model.metaTitle.uppercased()
        subtitle = model.subtitle
        imageURL = model.coverImage
        weekDay = getWeekDay(from: date)
        self.date = getDateString(from: date).uppercased()
    }

    private func getWeekDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    private func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
}
