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
        static let addButtonmarginBottom: CGFloat = 13.0
        static let monthCount: Int = 12
        static let headerHeight: CGFloat = 28.0
    }

    private let output: HomeViewOutput
    private let calendar = CalendarView()
    private let addButton = UIButton()
    private let tableView = UITableView()
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
        setupTitle()
        setupCalendar()
        setupButton()
        setupTableView()
        view.backgroundColor = ColorName.white.color
        output.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        calendar.pin
            .top(view.pin.safeArea + Constants.calendarTopMargin)
            .horizontally(Constants.calendarHorizontallyMargin)
            .height(Constants.calendarHeight)
        if let tabBarController = tabBarController {
            addButton.pin
                .above(of: tabBarController.tabBar, aligned: .center)
                .size(Constants.addButtonSideSize)
                .marginBottom(Constants.addButtonmarginBottom)
        }
        tableView.pin
            .below(of: calendar)
            .bottom()
            .horizontally()
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
    
    @objc
    private func addButtonDidTaped() {
        output.addButtonDidTap()
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = L10n.appName
        navigationItem.titleView = title
    }
    
    private func setupCalendar() {
        view.addSubview(calendar)
        let style = CalendarView.Style()
        style.cellSelectedColor = ColorName.mainPurple.color
        style.cellSelectedTextColor = ColorName.white.color
        style.cellSelectedBorderWidth = 0.0
        style.cellShape = .round
        style.cellColorDefault = .clear
        style.weekdaysTextColor = ColorName.black.color
        style.cellColorToday = .clear
        style.cellTextColorDefault = ColorName.black.color
        style.cellTextColorWeekend = ColorName.black.color
        calendar.style = style
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
        switch state {
        case .isLoading:
            break // TODO: ADD Loader
        case .empty:
            break // TODO: ADD EmptyView
        case .success:
            tableView.reloadData()
        case .faild:
            break // TODO: ADD FAILD STATE
        }
    }
}

extension HomeViewController: CalendarViewDataSource {
    func headerString(_ date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)
        return L10n.calendarTitle(month, year)
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
        output.dateDidChange(new: date)
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
