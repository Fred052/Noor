//
//  ProfileController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class ProfileController: BaseController {

    private let viewModel: ProfileViewModel

    var onSettings: (() -> Void)?
    var onCreateAccount: (() -> Void)?
    var onTheme: (() -> Void)?
    var onTranslation: (() -> Void)?
    var onMemorization: (() -> Void)?
    var onBookmarks: (() -> Void)?
    var onNotes: (() -> Void)?
    var onDownloads: (() -> Void)?
    var onPremium: (() -> Void)?
    var onPrivacy: (() -> Void)?
    var onHelp: (() -> Void)?

    init(viewModel: ProfileViewModel) {
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

    private lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.onSettingsTap = { [weak self] in self?.onSettings?() }
        view.onCreateAccountTap = { [weak self] in self?.onCreateAccount?() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var preferencesView: ProfilePreferencesView = {
        let view = ProfilePreferencesView()
        view.onThemeTap = { [weak self] in self?.onTheme?() }
        view.onTranslationTap = { [weak self] in self?.onTranslation?() }
        view.onMemorizationTap = { [weak self] in self?.onMemorization?() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var savedView: ProfileSavedView = {
        let view = ProfileSavedView()
        view.onBookmarksTap = { [weak self] in self?.onBookmarks?() }
        view.onNotesTap = { [weak self] in self?.onNotes?() }
        view.onDownloadsTap = { [weak self] in self?.onDownloads?() }
        view.onPremiumTap = { [weak self] in self?.onPremium?() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var accountView: ProfileAccountView = {
        let view = ProfileAccountView()
        view.onSettingsTap = { [weak self] in self?.onSettings?() }
        view.onPrivacyTap = { [weak self] in self?.onPrivacy?() }
        view.onHelpTap = { [weak self] in self?.onHelp?() }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(preferencesView)
        contentView.addSubview(savedView)
        contentView.addSubview(accountView)
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

            preferencesView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            preferencesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            preferencesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            savedView.topAnchor.constraint(equalTo: preferencesView.bottomAnchor, constant: 20),
            savedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            savedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            accountView.topAnchor.constraint(equalTo: savedView.bottomAnchor, constant: 20),
            accountView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    override func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.render()
        }
        viewModel.load()
    }

    private func render() {
        headerView.configure(userName: viewModel.userName, avatarLetter: viewModel.avatarLetter)

        if let summary = viewModel.summary {
            preferencesView.configure(summary: summary)
            savedView.configure(summary: summary)
        }
    }
}
