//
//  CreateAccountViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//
import UIKit

class CreateAccountViewController: UIViewController {
    private let output: CreateAccountViewOutput

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.createAccount
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
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.name
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.email
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .emailAddress
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .password
        return textField
    }()
    
    private var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.createAccount, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = FontFamily.Inter.medium.font(size: 22)
        button.layer.cornerRadius = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var alreadySignUpButton: UIButton = {
        let button = UIButton(type: .system)
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.Inter.regular.font(size: 14),
            .foregroundColor: ColorName.lightGrey.color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let attributeString = NSMutableAttributedString(
            string: L10n.alreadyHaveAccount,
            attributes: fontAttributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(output: CreateAccountViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        output.didTapCreateAccount()
    }
    
    @objc
    private func didTapLoginButton() {
        output.didTapLoginButton()
    }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(titleLabel, imageView, nameTextField, emailTextField, passwordTextField, createAccountButton, alreadySignUpButton)
    }
}

extension CreateAccountViewController: CreateAccountViewInput {
}

extension CreateAccountViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60),
            
            alreadySignUpButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 5),
            alreadySignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
