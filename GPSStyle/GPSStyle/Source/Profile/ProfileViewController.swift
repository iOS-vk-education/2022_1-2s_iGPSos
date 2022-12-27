//
//  ProfileViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit
import Firebase

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    
    init(output: ProfileViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.displayName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.email
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.name
        label.textColor = .systemGray
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: view.frame.width - 40, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        label.layer.addSublayer(bottomLine)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  emailLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.email
        label.textColor = .systemGray
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: view.frame.width - 40, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        label.layer.addSublayer(bottomLine)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.signOut, for: .normal)
        button.tintColor = ColorName.white.color
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = FontFamily.Inter.medium.font(size: 22)
        button.layer.cornerRadius = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func addTargets() {
        signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
    }
    
    @objc
    private func didTapSignOut() {
        try? Auth.auth().signOut()
        if Auth.auth().currentUser == nil {
            let vc = WelcomeViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    private func setupTitle() {
          let title = UILabel()
          title.text = "Профиль"
          title.font = FontFamily.Inter.medium.font(size: 22)
          navigationItem.titleView = title
      }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(signOutButton, emailLabel, nameLabel, userNameLabel, userEmailLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
        setConstraints()
        setupTitle()
    }
}

extension ProfileViewController: ProfileViewInput {
}

extension ProfileViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
//            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 45),
//            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            userEmailLabel.heightAnchor.constraint(equalToConstant: 40),
                        
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 45),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
