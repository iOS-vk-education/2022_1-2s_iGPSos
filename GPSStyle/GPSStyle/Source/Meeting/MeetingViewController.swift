//
//  MeetingViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 18.12.2022.
//

import UIKit
import PinLayout

class MeetingViewController: UIViewController {
    private var models: [CellModel] = []
    
    private var repeatEveryWeek: Bool = false
    
    private let titleLabelDate: UILabel = {
        let label = UILabel()
        label.text = L10n.timedate
        label.textColor = .black
        label.font = FontFamily.Inter.medium.font(size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.timedate
        let spacerView = UIView(frame:CGRect(x:5, y:0, width:50, height:30))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.purple.cgColor
        textField.layer.cornerRadius = 24
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
     lazy var dateTimePicker: DateTimePicker = {
        let picker = DateTimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (day, startDate, endDate) in
            let text = Date.buildTimeRangeString(dayDate: day, startDate: startDate, endDate: endDate)
            self?.dateTextField.text = text
        }
        return picker
    }()
    
    private let repeatEveryWeekButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle(L10n.repeatEveryWeek, for: .normal)
        button.setTitleColor(ColorName.black.color, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 18.0)
        
        button.setImage(UIImage(named: "repeat_every_week_off"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabelLook: UILabel = {
        let label = UILabel()
        label.text = L10n.look
        label.textColor = .black
        label.font = FontFamily.Inter.medium.font(size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idMeetingTableViewCell = "MeetingTableViewCell"
    
    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        setConstraints()
        createDatePicker()
        repeatEveryWeekButton.addTarget(self, action: #selector(didTapRepeatEveryWeek), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MeetingTableViewCell.self, forCellReuseIdentifier: idMeetingTableViewCell)
        
        models = [
            CellModel(id: 1,
                      title: "Вечерний образ",
                      imageUrl: "1645850968_1-krasavica-info-p-belie-tufli-na-belom-fone-devushka-krasivo-1.jpg"),
            CellModel(id: 2,
                      title: "Образ на обед",
                      imageUrl: "black-women-s-shoes-isolated-on-white-background-3d-rendering-illustration_97167-287.jpg.webp"),
            CellModel(id: 3,
                      title: "Спортивный образ",
                      imageUrl: "empty_10.jpg"),
            CellModel(id: 4,
                      title: "Образ на вечеринку",
                      imageUrl: "1645850968_1-krasavica-info-p-belie-tufli-na-belom-fone-devushka-krasivo-1.jpg"),
            CellModel(id: 5,
                      title: "На прогулку",
                      imageUrl: "1645850968_1-krasavica-info-p-belie-tufli-na-belom-fone-devushka-krasivo-1.jpg")
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup

    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(dateTextField, titleLabelDate, repeatEveryWeekButton, titleLabelLook, tableView)
    }
    
    private func setupNavBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = .black
        
        let title = UILabel()
        title.text = L10n.createMeeting
        title.font = FontFamily.Inter.medium.font(size: 22)
        navigationItem.titleView = title
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
    
        dateTextField.inputAccessoryView = toolbar
        
        dateTextField.inputView = dateTimePicker.inputView
    }
  
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    
    @objc private func didTapRepeatEveryWeek() {
        if !repeatEveryWeek {
            repeatEveryWeek = true
            repeatEveryWeekButton.setImage(UIImage(named: "repeat_every_week_on"), for: .normal)
        } else {
            repeatEveryWeek = false
            repeatEveryWeekButton.setImage(UIImage(named: "repeat_every_week_off"), for: .normal)
        }
    }
}

extension MeetingViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabelDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            dateTextField.topAnchor.constraint(equalTo: titleLabelDate.bottomAnchor, constant: 15),
            dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            dateTextField.heightAnchor.constraint(equalToConstant: 45),
            
            repeatEveryWeekButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 10),
            repeatEveryWeekButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            repeatEveryWeekButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            repeatEveryWeekButton.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabelLook.topAnchor.constraint(equalTo: repeatEveryWeekButton.bottomAnchor, constant: 10),
            titleLabelLook.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            tableView.topAnchor.constraint(equalTo: titleLabelLook.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension MeetingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idMeetingTableViewCell, for: indexPath) as? MeetingTableViewCell
        cell?.configure(with: models[indexPath.row])
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
