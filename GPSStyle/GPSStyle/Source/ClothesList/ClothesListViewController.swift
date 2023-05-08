//
//  ClothesListViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit
import Firebase
import FirebaseAuth

final class ClothesListViewController: UIViewController {
    private let output: ClothesListViewOutput
    private enum Constants {
        static let addButtonSideSize: CGFloat = 80.0
        static let addButtonMarginBottom: CGFloat = 13.0
    }
    private let addButton = UIButton()
    private let tableView = UITableView()
    
    init(output: ClothesListViewOutput) {
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
        setupTableView()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        if let tabBarController = tabBarController {
            addButton.pin
                .above(of: tabBarController.tabBar, aligned: .center)
                .size(Constants.addButtonSideSize)
                .marginBottom(Constants.addButtonMarginBottom)
        }
        tableView.pin.all()
        tableView.contentInset.bottom = Constants.addButtonSideSize + Constants.addButtonMarginBottom
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ClothesTableViewCell.self, forCellReuseIdentifier: ClothesTableViewCell.cellReuseIdentifier)
    }
    
    private func setupButton() {
        view.addSubview(addButton)
        addButton.setImage(Asset.add.image, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = L10n.cloth
        title.font = FontFamily.Inter.medium.font(size: 22)
        navigationItem.titleView = title
    }
    
    @objc
    private func addButtonDidTap() {
        output.addButtonDidTap()
    }
}

extension ClothesListViewController: ClothesListViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

extension ClothesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.clothDidTap(with: indexPath)
    }
}

extension ClothesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        output.getTitle(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        output.getSectionCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.getCellCount(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ClothesTableViewCell.cellReuseIdentifier,
            for: indexPath
        ) as? ClothesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: output.getCell(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, _) in
            DispatchQueue.main.async {
                self?.showDeleteWarningCloth(for: indexPath)
            }
        }
        deleteAction.backgroundColor = .white
        deleteAction.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
    func showDeleteWarningCloth(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "Вы уверены, что хотите удалить элемент?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Назад", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            DispatchQueue.main.async { [self] in
                self.output.removeCell(at: indexPath)
                self.tableView.reloadData()
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
}
