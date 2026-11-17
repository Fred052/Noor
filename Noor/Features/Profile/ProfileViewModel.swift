//
//  ProfileViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import Foundation

final class ProfileViewModel {

    var success: (() -> Void)?

    let userName: String
    private(set) var summary: ProfileSummary?

    init(userName: String) {
        self.userName = userName
    }

    var avatarLetter: String { String(userName.prefix(1)).uppercased() }

    func load() {
        summary = ProfileSummary(readingTheme: "Light",
                                 translation: "Sahih International",
                                 versesMemorized: 6,
                                 memorizationProgress: 0.4,
                                 nextReview: "Next review tomorrow",
                                 bookmarks: 2,
                                 notes: 2,
                                 downloads: 1)
        success?()
    }
}
