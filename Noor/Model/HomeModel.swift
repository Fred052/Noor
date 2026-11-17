//
//  HomeModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

enum QuickAction {
    case readQuran, listen, memorize, explore
}

struct LastRead {
    let surahName: String
    let page: Int
    let verse: Int
    let totalVerses: Int
    var progress: Float { Float(verse) / Float(totalVerses) }
}

struct TodayReading {
    let doneMinutes: Int
    let goalMinutes: Int
    var progress: CGFloat { CGFloat(doneMinutes) / CGFloat(goalMinutes) }
}

struct DailyVerse {
    let arabic: String
    let translation: String
    let reference: String
}

struct ActivityItem {
    let iconName: String
    let title: String
    let time: String
}

struct NextStep {
    let title: String
    let subtitle: String
    let buttonTitle: String
}
