//
//  MeetingViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 05.12.2022.
//

import UIKit

class MeetingViewController: UIViewController {
    private var repeatEveryWeek: Bool = false
    
    private let titleLabelDate: UILabel = {
        let label = UILabel()
        label.text = "Время и дата"
        label.textColor = .black
        label.font = FontFamily.Inter.medium.font(size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Время и дата"
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
        label.text = "Образ"
        label.textColor = .black
        label.font = FontFamily.Inter.medium.font(size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        setConstraints()
        createDatePicker()
        repeatEveryWeekButton.addTarget(self, action: #selector(didTapRepeatEveryWeek), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(dateTextField, titleLabelDate, repeatEveryWeekButton, titleLabelLook)
    }
    
    private func setupNavBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = .black
        
        let title = UILabel()
        title.text = "Создать встречу"
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
            titleLabelLook.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
}
