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
    
    func setupViews(){
        view.backgroundColor = ColorName.white.color
        view.addSubviews(signOutButton)
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
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
