//
//  ClothesCreateViewController.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateViewController: UIViewController {
    private let output: ClothesCreateViewOutput
    
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let clothingSizeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.size
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let clothingColorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.color
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let clothingBrandTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.brand
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    }
    
    func setupViews() {
        view.backgroundColor = ColorName.white.color
        
        view.addSubview(clothingNameTextField)
        view.addSubview(clothesImageView)
        view.addSubview(selectPhotoButton)
        view.addSubview(clothingSizeTextField)
        view.addSubview(clothingColorTextField)
        view.addSubview(clothingBrandTextField)
        view.addSubview(checkTheWeatherButton)
        view.addSubview(cretateClothesButton)
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
    
    // TODO: добавить место для фотографии imageView
    
    @objc private func didTapSelectPhoto() {
        // TODO: выбор фото
        presentPhotoActionSheet()
        if clothesImageView.image != nil { // Надо изменить
            selectPhotoButton.setTitle("Изменить фото", for: .normal)
        } else {
            selectPhotoButton.setTitle(L10n.addPhoto, for: .normal)
        }
    }
    
    @objc private func didTapCheckWeather() {
        // TODO: добавить отслеживание погоды
        if !checkTheWeather {
            checkTheWeather = true
            checkTheWeatherButton.setImage(UIImage(named: "check_weather_on"), for: .normal)
        } else {
            checkTheWeather = false
            checkTheWeatherButton.setImage(UIImage(named: "check_weather_off"), for: .normal)
        }
        
    }
    
    @objc private func didTapCreateClothes() {
        // TODO: создать вещь
        let vc = ClothesCreateContainer.assemble(with: ClothesCreateContext()).viewController
        present(vc, animated: true, completion: nil)
    }
    
    // TODO: Выборку вариантов в Размер, Цвет и Брэнд
}

extension ClothesCreateViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            // Cloting name text field
            clothingNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            clothingNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Clothing ImageView
            clothesImageView.topAnchor.constraint(equalTo: clothingNameTextField.bottomAnchor, constant: 15),
            clothesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            clothesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            clothesImageView.heightAnchor.constraint(equalToConstant: 180),
            
            // Select photo button
            selectPhotoButton.topAnchor.constraint(equalTo: clothesImageView.bottomAnchor, constant: 10),
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
        
        present(actionSheet, animated: true)
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
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.clothesImageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
