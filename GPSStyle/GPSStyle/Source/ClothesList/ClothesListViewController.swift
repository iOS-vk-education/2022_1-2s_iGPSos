//
//  ClothesListViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

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
        title.text = L10n.looks
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
       // output.clothDidTap(with: indexPath)
    }
}

extension ClothesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.countList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ClothesTableViewCell.cellReuseIdentifier,
            for: indexPath
        ) as? ClothesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: output.getCloth(index: indexPath.row))
        return cell
    }
}
