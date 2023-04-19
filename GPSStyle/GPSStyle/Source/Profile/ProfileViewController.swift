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
    private enum Constants {
        static let layerCornerRadius:  CGFloat = 30.0
        static let layerShadowRadius:  CGFloat = 2.0
        static let layerShadowOpacity: Float = 0.2
        static let shadowOffsetHeight: CGFloat = 5.0
        static let shadowOffsetWidth:  CGFloat = 0.0
        static let labelLeading: CGFloat = 45.0
        static let labelTrailing: CGFloat = -40.0
        static let viewLeading: CGFloat = 20.0
        static let viewTrailing: CGFloat = -20.0
        static let userLableTop: CGFloat = 25.0
        static let userLabelHeight: CGFloat = 40.0
        static let labelHeight: CGFloat = 56.0
        static let buttonHeight: CGFloat = 65.0
        static let buttonBottom: CGFloat = -30.0
        static let nameTop: CGFloat = 20.0
        static let emailTop: CGFloat = 70.0
    }
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
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.email
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.layerCornerRadius
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: Constants.shadowOffsetWidth, height: Constants.shadowOffsetHeight)
        view.layer.shadowRadius = Constants.layerShadowRadius
        view.layer.shadowOpacity = Constants.layerShadowOpacity
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.name
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.layerCornerRadius
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: Constants.shadowOffsetWidth, height: Constants.shadowOffsetHeight)
        view.layer.shadowRadius = Constants.layerShadowRadius
        view.layer.shadowOpacity = Constants.layerShadowOpacity
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  emailLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.email
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var signOutButton = CustomButton()
    
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
        title.text = L10n.profile
          title.font = FontFamily.Inter.medium.font(size: 22)
          navigationItem.titleView = title
      }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(signOutButton, emailView, emailLabel, nameView, nameLabel, userNameLabel, userEmailLabel)
        signOutButton.setTitle(L10n.signOut, for: .normal)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
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
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.userLableTop),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.labelTrailing),
            userNameLabel.heightAnchor.constraint(equalToConstant: Constants.userLabelHeight),
            
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: Constants.emailTop),
            userEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.labelTrailing),
            userEmailLabel.heightAnchor.constraint(equalToConstant: Constants.userLabelHeight),
                        
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.nameTop),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelLeading),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.viewTrailing),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            
            nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.nameTop),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.viewLeading),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.viewTrailing),
            nameView.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: Constants.emailTop),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelLeading),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.viewTrailing),
            emailLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            
            emailView.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: Constants.emailTop),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.viewLeading),
            emailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.viewTrailing),
            emailView.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonBottom),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.viewLeading),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.viewTrailing),
            signOutButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
}
