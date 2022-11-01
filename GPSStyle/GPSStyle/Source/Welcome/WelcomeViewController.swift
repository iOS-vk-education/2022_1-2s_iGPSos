//
//  WelcomeViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GPStyle"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать аккаунт", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.6730021834, green: 0.4277178049, blue: 0.6891061068, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.layer.cornerRadius = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var alreadySignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Уже есть аккаунт?", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.6117647059, blue: 0.6705882353, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.layer.cornerRadius = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addTargets()
    }
    
    private func addTargets() {
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        alreadySignUpButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapCreateAccount() {
        let vc = CreateAccountViewController()
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func didTapLoginButton() {
        let vc = LoginViewController()
        present(vc, animated: true, completion: nil)
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(createAccountButton)
        view.addSubview(alreadySignUpButton)
    }
}
    
extension WelcomeViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 65),
            
            alreadySignUpButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 5),
            alreadySignUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alreadySignUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            alreadySignUpButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
