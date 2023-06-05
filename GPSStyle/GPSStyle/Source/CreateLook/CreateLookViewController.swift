//
//  CreateLookViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.11.2022.
//  
//

import UIKit

final class CreateLookViewController: UIViewController {
    private let output: CreateLookViewOutput
    
    private lazy var lookNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 30
        textField.placeholder = L10n.title
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        textField.leftViewMode = .always
    
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowRadius = 2
        textField.layer.shadowOpacity = 0.2
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.register(ClothTableViewCell.self, forCellReuseIdentifier: ClothTableViewCell.cellReuseIdentifier)
        return tableView
    }()
    
    init(output: CreateLookViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupTitle()
        setupViews()
        output.viewDidLoad()
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = L10n.createClothes
        title.font = FontFamily.Inter.medium.font(size: 22)
        navigationItem.titleView = title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: L10n.add,
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
    }
    
    @objc
    private func addTapped() {
        output.createLook(with: lookNameTextField.text)
    }

    private func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(lookNameTextField, tableView)
    }
    
    override func viewDidLayoutSubviews() {
        lookNameTextField.pin
            .top(view.safeAreaInsets)
            .marginTop(20)
            .horizontally(20)
            .height(56)
        tableView.pin
            .below(of: lookNameTextField)
            .marginTop(15)
            .horizontally()
            .bottom()
    }
}

extension CreateLookViewController: CreateLookViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

extension CreateLookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.countList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ClothTableViewCell.cellReuseIdentifier,
            for: indexPath
        ) as? ClothTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: output.getCloth(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.updateIsSelected(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        output.updateIsSelected(index: indexPath.row)
    }
}
