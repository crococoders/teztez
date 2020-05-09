//
//  File.swift
//  
//
//  Created by Temirkhan Sailau on 5/9/20.
//

public enum DateFilter:String,Codable,CaseIterable{
    case forToday = "for_today"
    case forLastWeek = "for_last_week"
    case forLastMonth = "for_last_month"
    case overall
    
    var clientReadable: String{
        switch self {
        case .forToday:
            return "since yesterday"
        case .forLastWeek:
            return "since last week"
        case .forLastMonth:
            return "since last month"
        case .overall:
            return "for all time"
    }
}
