//
//  WelcomeViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 07.11.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.appName
        label.textColor = .black
        label.font = FontFamily.Inter.bold.font(size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var createAccountButton = CustomButton()
    
    private var alreadySignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.alreadyHaveAccount, for: .normal)
        button.tintColor = .lightGray
        button.titleLabel?.font = FontFamily.Inter.regular.font(size: 14)
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 25, width: 125, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        button.layer.addSublayer(bottomLine)
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
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func didTapLoginButton() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubview(titleLabel)
        view.addSubview(createAccountButton)
        view.addSubview(alreadySignUpButton)
        createAccountButton.setTitle(L10n.createAccount, for: .normal)
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
            alreadySignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
