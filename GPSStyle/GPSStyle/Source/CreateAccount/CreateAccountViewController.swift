//
//  CreateAccountViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 01.11.2022.
//
import UIKit

class CreateAccountViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создать аккаунт"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
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
        textField.placeholder = "Почта"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        button.tintColor = .lightGray
//        button.backgroundColor = #colorLiteral(red: 0.6730021834, green: 0.4277178049, blue: 0.6891061068, alpha: 1)
        
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 30, width: 170, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
//        button.borderStyle = .none
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
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func didTapLoginButton() {
        let from = LoginViewController()
        present(from, animated: true, completion: nil)
    }
    
    func setupViews(){
        view.backgroundColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        view.addSubview(alreadySignUpButton)
    }
}

extension CreateAccountViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
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
            alreadySignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
