//
//  HomeViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit
import PinLayout

final class HomeViewController: UIViewController {
    private enum Constants {
        static let calendarTopMargin: CGFloat = 10.0
        static let calendarHorizontallyMargin: CGFloat = 35.0
        static let calendarHeight: CGFloat = 300.0
        static let addButtonSideSize: CGFloat = 80.0
        static let addButtonMarginBottom: CGFloat = 13.0
        static let monthCount: Int = 12
        static let headerHeight: CGFloat = 28.0
        static let spinnerHeight: CGFloat = 56.0
        static let titleTopMargin: CGFloat = 46.0
        static let errorButtonTopMargin: CGFloat = 24.0
        static let errorButtonWidth: CGFloat = 265.0
        static let errorButtonHeight: CGFloat = 45.0
        static let errorLabelHeight: CGFloat = 56.0
        static let buttonCornerRadius: CGFloat = Constants.errorButtonHeight / 2
    }

    private let output: HomeViewOutput
    private let calendar = CalendarView()
    private let addButton = UIButton()
    private let tableView = UITableView()
    private let errorLabel = UILabel()
    private let errorButton = UIButton()
    private lazy var spinner: Spinner = {
        let spinner = Spinner(squareLength: Constants.spinnerHeight)
        return spinner
    }()

    init(output: HomeViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorName.white.color
        setupTitle()
        setupCalendar()
        setupTableView()
        setupSpinner()
        setupErrorLabel()
        setupErrorButton()
        setupButton()
        output.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendar.selectDate(Date()) // by default selected is now
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        calendar.pin
            .top(view.pin.safeArea.top + Constants.calendarTopMargin)
            .horizontally(Constants.calendarHorizontallyMargin)
            .height(Constants.calendarHeight)
        if let tabBarController = tabBarController {
            addButton.pin
                .above(of: tabBarController.tabBar, aligned: .center)
                .size(Constants.addButtonSideSize)
                .marginBottom(Constants.addButtonMarginBottom)
        }
        tableView.pin
            .below(of: calendar)
            .bottom()
            .horizontally()
        errorLabel.pin
            .below(of: calendar)
            .marginTop(Constants.titleTopMargin)
            .horizontally()
            .height(Constants.errorLabelHeight)
        errorButton.pin
            .below(of: errorLabel)
            .marginTop(Constants.errorButtonTopMargin)
            .hCenter()
            .width(Constants.errorButtonWidth)
            .height(Constants.errorButtonHeight)
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.font = FontFamily.Inter.medium.font(size: 22)
        errorLabel.textColor = ColorName.lightGrey.color
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.cellReuseIdentifier)
    }
    
    private func setupButton() {
        view.addSubview(addButton)
        addButton.setImage(Asset.add.image, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonDidTaped), for: .touchUpInside)
    }
    
    private func setupErrorButton() {
        view.addSubview(errorButton)
        errorButton.layer.cornerRadius = Constants.buttonCornerRadius
        errorButton.setTitle(L10n.reload, for: .normal)
        errorButton.setTitleColor(ColorName.white.color, for: .normal)
        errorButton.backgroundColor = ColorName.mainPurple.color
        errorButton.titleLabel?.font = FontFamily.Inter.semiBold.font(size: 20)
        errorButton.addTarget(self, action: #selector(errorButtonDidTaped), for: .touchUpInside)
    }

    @objc
    private func errorButtonDidTaped() {
        output.reloadData()
    }
    
    @objc
    private func addButtonDidTaped() {
        output.addButtonDidTap()
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = L10n.appName
        title.font = FontFamily.Inter.medium.font(size: 22)
        navigationItem.titleView = title
    }
    
    private func setupCalendar() {
        view.addSubview(calendar)
        calendar.style = CalendarView.Style()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.direction = .horizontal
        calendar.multipleSelectionEnable = false
        calendar.enableDeslection = false
        calendar.marksWeekends = true
    }
}

extension HomeViewController: HomeViewInput {
    func update(with state: HomeState) {
        errorLabel.text = state.getErrorTitle
        errorLabel.isHidden = !state.shouldShowErrorLabel
        errorButton.isHidden = !state.shouldShowErrorButton
        state.isLoading ? spinner.startAnimation() : spinner.stopAnimation()
        if state.isFinished {
            tableView.reloadData()
        }
    }
}

extension HomeViewController: CalendarViewDataSource {
    func headerString(_ date: Date) -> String? {
        let titleValues = output.configureCalendarTitle(date: date)
        return L10n.calendarTitle(titleValues.0, titleValues.1)
    }
    
    func startDate() -> Date {
        return Date()
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = Constants.monthCount
        let today = Date()
        
        guard let twoYearsFromNow = calendar.calendar.date(byAdding: dateComponents, to: Date()) else {
            return today
        }
        
        return twoYearsFromNow
    }
}

extension HomeViewController: CalendarViewDelegate {
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        true
    }

    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        output.dateDidChange(with: date)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = FontFamily.Inter.medium.font(size: 18)
        header?.textLabel?.textColor = ColorName.black.color
        header?.backgroundConfiguration = .listPlainCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.clothDidTap(with: indexPath)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        output.lookList[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        output.lookList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.lookList[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.cellReuseIdentifier,
            for: indexPath
        ) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: output.lookList[indexPath.section].rows[indexPath.row])
         return cell
    }
}
