//
//  ClothesCreateViewController.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateViewController: UIViewController {
    private let output: ClothesCreateViewOutput
    
    private var supportConstraint: NSLayoutConstraint?
    
    private var checkTheWeather: Bool = false
    
    private let clothingNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.clothesName
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let clothesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.addPhoto, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 22.0)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let clothingSizeTextField: UILabel = {
        let label = UILabel()
        label.text = L10n.size
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        label.layer.addSublayer(bottomLine)
        return label
    }()
    
    private let clothingColorTextField: UILabel = {
        let label = UILabel()
        label.text = L10n.color
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        label.layer.addSublayer(bottomLine)
        return label
    }()
    
    private let clothingBrandTextField: UILabel = {
        let label = UILabel()
        label.text = L10n.brand
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        label.layer.addSublayer(bottomLine)
        return label
    }()
    
    private let checkTheWeatherButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle(L10n.checkTheWeather, for: .normal)
        button.setTitleColor(ColorName.black.color, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 18.0)
        
        button.setImage(UIImage(named: "check_weather_off"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cretateClothesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.createClothes, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 22.0)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(output: ClothesCreateViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTitle()
        setConstraints()
        addTargets()
        setupPickersViews()
    }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        view.addSubviews(clothingNameTextField,
                         clothesImageView,
                         selectPhotoButton,
                         clothingSizeTextField,
                         clothingColorTextField,
                         clothingBrandTextField,
                         checkTheWeatherButton,
                         cretateClothesButton)
    }
    
    func setupPickersViews() {
        let recognierSize = UITapGestureRecognizer(target: self, action: #selector(didTapSizeLabel))
        clothingSizeTextField.addGestureRecognizer(recognierSize)
        
        let recognierColor = UITapGestureRecognizer(target: self, action: #selector(didTapColorLabel))
        clothingColorTextField.addGestureRecognizer(recognierColor)
        
        let recognierBrand = UITapGestureRecognizer(target: self, action: #selector(didTapBrandLabel))
        clothingBrandTextField.addGestureRecognizer(recognierBrand)
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = L10n.createClothes
        title.font = FontFamily.Inter.medium.font(size: 22)
        navigationItem.titleView = title
    }
    
    private func addTargets() {
        selectPhotoButton.addTarget(self, action: #selector(didTapSelectPhoto), for: .touchUpInside)
        checkTheWeatherButton.addTarget(self, action: #selector(didTapCheckWeather), for: .touchUpInside)
        cretateClothesButton.addTarget(self, action: #selector(didTapCreateClothes), for: .touchUpInside)
    }
    
    @objc
    private func didTapSelectPhoto() {
        presentPhotoActionSheet()
    }
    
    @objc
    private func didTapCheckWeather() {
        if !checkTheWeather {
            checkTheWeather = true
            checkTheWeatherButton.setImage(UIImage(named: "check_weather_on"), for: .normal)
        } else {
            checkTheWeather = false
            checkTheWeatherButton.setImage(UIImage(named: "check_weather_off"), for: .normal)
        }
    }
    
    @objc
    private func didTapSizeLabel() {
        let clothesCreatePickerSizeViewController = ClothesCreatePickerViewController()
        clothesCreatePickerSizeViewController.configure(with: pickerUnitClothesSize)
        let nav = UINavigationController(rootViewController: clothesCreatePickerSizeViewController)
        nav.modalPresentationStyle = .pageSheet
        if let nav = nav.presentationController as? UISheetPresentationController {
            nav.prefersGrabberVisible = true
            nav.detents = [.custom { _ in return 300 }]
        }
        present(nav, animated: true)
    }
    
    @objc
    private func didTapColorLabel() {
        let clothesCreatePickerSizeViewController = ClothesCreatePickerViewController()
        clothesCreatePickerSizeViewController.configure(with: pickerUnitClothesColor)
        let nav = UINavigationController(rootViewController: clothesCreatePickerSizeViewController)
        nav.modalPresentationStyle = .pageSheet
        if let nav = nav.presentationController as? UISheetPresentationController {
            nav.prefersGrabberVisible = true
            nav.detents = [.custom { _ in return 300 }]
        }
        present(nav, animated: true)
    }
    
    @objc
    private func didTapBrandLabel() {
        let clothesCreatePickerBrandViewController = ClothesCreatePickerViewController()
        clothesCreatePickerBrandViewController.configure(with: pickerUnitClothesBrand)
        let nav = UINavigationController(rootViewController: clothesCreatePickerBrandViewController)
        nav.modalPresentationStyle = .pageSheet
        if let nav = nav.presentationController as? UISheetPresentationController {
            nav.prefersGrabberVisible = true
            nav.detents = [.custom { _ in return 300 }]
        }
        present(nav, animated: true)
    }
    
    @objc
    private func didTapCreateClothes() {
        let vc = ClothesCreateContainer.assemble(with: ClothesCreateContext()).viewController
        present(vc, animated: true, completion: nil)
    }
}

extension ClothesCreateViewController {
    private func setConstraints() {
        updateConstraints()
        guard let supportConstraint = supportConstraint else {
            return
        }
        NSLayoutConstraint.activate([
            // Cloting name text field
            clothingNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            clothingNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Clothing ImageView
            clothesImageView.topAnchor.constraint(equalTo: clothingNameTextField.bottomAnchor, constant: 15),
            clothesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 107),
            clothesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -107),
            clothesImageView.heightAnchor.constraint(equalToConstant: 180),
            
            // Select photo button
            supportConstraint,
            selectPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            selectPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 60),
            
            // Cloting size text field
            clothingSizeTextField.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 15),
            clothingSizeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingSizeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingSizeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Cloting color text field
            clothingColorTextField.topAnchor.constraint(equalTo: clothingSizeTextField.bottomAnchor, constant: 5),
            clothingColorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingColorTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingColorTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Cloting brand text field
            clothingBrandTextField.topAnchor.constraint(equalTo: clothingColorTextField.bottomAnchor, constant: 5),
            clothingBrandTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingBrandTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingBrandTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Checking for the weather tracking
            checkTheWeatherButton.topAnchor.constraint(equalTo: clothingBrandTextField.bottomAnchor, constant: 10),
            checkTheWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            checkTheWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            checkTheWeatherButton.heightAnchor.constraint(equalToConstant: 60),
            
            // Create clothes button
            cretateClothesButton.topAnchor.constraint(equalTo: checkTheWeatherButton.topAnchor, constant: 60),
            cretateClothesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cretateClothesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            cretateClothesButton.heightAnchor.constraint(equalToConstant: 60)
        ] )
    }
    
    private func updateConstraints() {
        supportConstraint?.isActive = false
        supportConstraint = clothesImageView.image == nil ?
        selectPhotoButton.topAnchor.constraint(equalTo: clothingNameTextField.bottomAnchor, constant: 15) :
        selectPhotoButton.topAnchor.constraint(equalTo: clothesImageView.bottomAnchor, constant: 15)
        supportConstraint?.isActive = true
    }
}

extension ClothesCreateViewController: ClothesCreateViewInput {
}

extension ClothesCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: L10n.clothesPhoto,
                                            message: L10n.howAddPhoto,
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: L10n.cancel,
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: L10n.takePhoto,
                                            style: .default,
                                            handler: { [weak self] _ in self?.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: L10n.choosePhoto,
                                            style: .default,
                                            handler: { [weak self] _ in self?.presentPhotoPicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: L10n.deletePhoto,
                                            style: .default,
                                            handler: { [weak self] _ in self?.deletePhoto()
        }))
        
        present(actionSheet, animated: true)
    }
    
    private func deletePhoto() {
        self.clothesImageView.image = nil
        updateConstraints()
    }
    
    private func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    private func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        self.clothesImageView.image = selectedImage
        if clothesImageView.image != nil {
            selectPhotoButton.setTitle(L10n.changePhoto, for: .normal)
        } else {
            selectPhotoButton.setTitle(L10n.addPhoto, for: .normal)
        }
        updateConstraints()
    }
}
