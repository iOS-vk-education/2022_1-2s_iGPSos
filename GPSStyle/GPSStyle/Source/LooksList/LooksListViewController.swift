//
//  LooksListViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class LooksListViewController: UIViewController {
    private enum Constants {
        static let addButtonSideSize: CGFloat = 80.0
        static let addButtonMarginBottom: CGFloat = 13.0
        static let errorButtonTopMargin: CGFloat = 24.0
        static let errorButtonWidth: CGFloat = 265.0
        static let errorButtonHeight: CGFloat = 45.0
        static let errorLabelHeight: CGFloat = 56.0
        static let spinnerHeight: CGFloat = 56.0
        static let buttonCornerRadius: CGFloat = Constants.errorButtonHeight / 2
    }
    private let output: LooksListViewOutput
    private let addButton = UIButton()
    private let tableView = UITableView()
    private let errorLabel = UILabel()
    private let errorButton = UIButton()
    private lazy var spinner: Spinner = {
        let spinner = Spinner(squareLength: Constants.spinnerHeight)
        return spinner
    }()
    
    init(output: LooksListViewOutput) {
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
        setupErrorLabel()
        setupSpinner()
        setupErrorButton()
        output.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        errorLabel.pin
            .top(view.pin.safeArea.top + Constants.errorButtonTopMargin)
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
        output.getData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset.top = 4
        tableView.contentInset.bottom = Constants.addButtonSideSize + Constants.addButtonMarginBottom
        tableView.register(LookTableViewCell.self, forCellReuseIdentifier: LookTableViewCell.cellReuseIdentifier)
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

extension LooksListViewController: LooksListViewInput {
    func update(with state: ControllerState) {
        errorLabel.text = state.getErrorTitle
        errorLabel.isHidden = !state.shouldShowErrorLabel
        errorButton.isHidden = !state.shouldShowErrorButton
        state.isLoading ? spinner.startAnimation() : spinner.stopAnimation()
        if state.isFinished {
            tableView.reloadData()
        }
    }
}

extension LooksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // output.clothDidTap(with: indexPath)
    }
}

extension LooksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.countList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LookTableViewCell.cellReuseIdentifier,
            for: indexPath
        ) as? LookTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: output.getLook(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LookTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, _) in
            DispatchQueue.main.async {
                self?.showDeleteWarningLook(for: indexPath)
            }
        }
        deleteAction.backgroundColor = .white
        deleteAction.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
    func showDeleteWarningLook(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "Вы уверены, что хотите удалить элемент?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Назад", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            DispatchQueue.main.async { [self] in
                self.output.removeLook(for: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
}
