//
//  LoginViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 07.11.2022.
//

import UIKit
import Firebase
import Combine

class LoginViewController: UIViewController {
    private var userModel = AuthenticationModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.login
        label.textColor = .black
        label.font = FontFamily.Inter.medium.font(size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.logo.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.email
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.textContentType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.password
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.login, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = FontFamily.Inter.medium.font(size: 22.0)
        button.layer.cornerRadius = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func didChangeEmailField() {
        userModel.email = emailTextField.text
        userModel.validateAuthenticationForm()
    }
    
    @objc private func didChangePasswordField() {
        userModel.password = passwordTextField.text
        userModel.validateAuthenticationForm()
    }
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        
        userModel.$isAuthenticationFormValid.sink { [weak self] validationState in
            self?.loginButton.isEnabled = validationState
        }
        .store(in: &subscriptions)
        
        userModel.$user.sink { [weak self] user in
//            guard user != nil else { return }
            if user != nil {
                let vc = MainTabBarController(tabBarModel: TabBarModelImpl())
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
        }
        .store(in: &subscriptions)
        
        userModel.$error.sink { [weak self] errorString in
            guard let error = errorString else { return }
            self?.presentAlert(with: error)
        }
        .store(in: &subscriptions)
    }
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        addTargets()
        bindViews()
    }
    
    private func addTargets() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
                                
    @objc
    private func didTapLogin() {
        userModel.loginUser()
    }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(titleLabel, imageView, emailTextField, passwordTextField, loginButton)
    }
}

extension LoginViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
