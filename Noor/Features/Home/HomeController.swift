//
//  HomeController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class HomeController: BaseController {

    private let viewModel: HomeViewModel

    var onContinueReading: (() -> Void)?
    var onTodayReading: (() -> Void)?
    var onQuickAction: ((QuickAction) -> Void)?
    var onNextStep: (() -> Void)?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var readingView: HomeReadingView = {
        let view = HomeReadingView()
        view.onContinueTap = { [weak self] in self?.onContinueReading?() }
        view.onTodayTap = { [weak self] in self?.onTodayReading?() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var shortcutsView: HomeShortcutsView = {
        let view = HomeShortcutsView()
        view.onQuickAction = { [weak self] action in self?.onQuickAction?(action) }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var activityView: HomeActivityView = {
        let view = HomeActivityView()
        view.onNextStepTap = { [weak self] in self?.onNextStep?() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(readingView)
        contentView.addSubview(shortcutsView)
        contentView.addSubview(activityView)
    }

    override func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            readingView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            readingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            readingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            shortcutsView.topAnchor.constraint(equalTo: readingView.bottomAnchor, constant: 20),
            shortcutsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortcutsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            activityView.topAnchor.constraint(equalTo: shortcutsView.bottomAnchor, constant: 24),
            activityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            activityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    override func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.render()
        }
        viewModel.load()
    }

    private func render() {
        headerView.configure(dateText: viewModel.dateText,
                             greetingText: viewModel.greetingText,
                             avatarLetter: viewModel.avatarLetter)

        if let lastRead = viewModel.lastRead, let today = viewModel.today {
            readingView.configure(lastRead: lastRead, today: today)
        }

        if let verse = viewModel.dailyVerse {
            shortcutsView.configure(verse: verse)
        }

        if let nextStep = viewModel.nextStep {
            activityView.configure(activities: viewModel.activities, nextStep: nextStep)
        }
    }
}
