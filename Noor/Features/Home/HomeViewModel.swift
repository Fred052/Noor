//
//  HomeViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import Foundation

final class HomeViewModel {

    var success: (() -> Void)?

    let userName: String
    private(set) var lastRead: LastRead?
    private(set) var today: TodayReading?
    private(set) var dailyVerse: DailyVerse?
    private(set) var activities: [ActivityItem] = []
    private(set) var nextStep: NextStep?

    init(userName: String) {
        self.userName = userName
    }

    var dateText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: Date())
    }

    var greetingText: String { "Assalamu alaikum, \(userName)" }
    var avatarLetter: String { String(userName.prefix(1)).uppercased() }

    func load() {
        lastRead = LastRead(
            surahName: "Surah Al-Baqarah",
            page: 22,
            verse: 142,
            totalVerses: 286
        )
        today = TodayReading(
            doneMinutes: 6,
            goalMinutes: 10
        )
        dailyVerse = DailyVerse(arabic: "فَإِنَّ مَعَ ٱلْعُسْرِ يُسْرًا",
                                translation: "For indeed, with hardship [will be] ease.",
                                reference: "Ash-Sharh 94:5 · Sahih International")
        activities = [
            ActivityItem(
                iconName: "iconBook",
                title: "Read · Al-Mulk 67:1–5",
                time: "Yesterday"
            ),
            ActivityItem(
                iconName: "iconHeadphones",
                title: "Listened · Al-Kahf",
                time: "2 days ago"
            ),
            ActivityItem(
                iconName: "iconHifz",
                title: "Revised · Al-Ikhlas",
                time: "3 days ago"
            )
        ]
        nextStep = NextStep(title: "Explore the meaning of 94:5",
                            subtitle: "Chosen because you want to understand the meaning.",
                            buttonTitle: "Open ayah study")
        success?()
    }
}
