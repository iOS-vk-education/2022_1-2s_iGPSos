//
//  ClothesCreateViewController.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateViewController: UIViewController {
    private let output: ClothesCreateViewOutput
    
    /*
    private let clothingNameTextField = UITextField()
    private let clothingSizeTextField = UITextField()
    private let clothingColorTextField = UITextField()
    private let clothingBrandTextField = UITextField()
    private let selectPhotoButton = UIButton()
    */
    
    private let clothingNameTextField: UITextField = {
     let textField = UITextField()
     textField.placeholder = "Название"
     var bottomLine = CALayer()
     bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
     bottomLine.backgroundColor = UIColor.lightGray.cgColor
     textField.borderStyle = .none
     textField.layer.addSublayer(bottomLine)
     textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let clothingSizeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Размер"
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
        textField.placeholder = "Цвет"
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
        textField.placeholder = "Брэнд"
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
        button.setTitle("Добавить фото", for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let checkTheWeatherButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Отслеживать погоду", for: .normal)
        button.setImage(UIImage(named: "check_weather_off"), for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .left
        // button.imageEdgeInsets.left = -50
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cretateClothesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать", for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
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
        // addTargets()  // TODO: add targets
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(clothingNameTextField)
        view.addSubview(selectPhotoButton)
        view.addSubview(clothingSizeTextField)
        view.addSubview(clothingColorTextField)
        view.addSubview(clothingBrandTextField)
        view.addSubview(checkTheWeatherButton)
        view.addSubview(cretateClothesButton)
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = "Создать"
        title.font = FontFamily.Inter.medium.font(size: 22)
        navigationItem.titleView = title
    }
    
    /*
    private func setupClothingNameTextField() {
        view.addSubview(clothingNameTextField)
        let textField = UITextField()
        textField.placeholder = "Название"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSelectPhotoButton() {
        view.addSubview(selectPhotoButton)
        let button = UIButton(type: .system)
        button.setTitle("Добавить фото", for: .normal)
        button.tintColor = .white
        button.backgroundColor = ColorName.mainPurple.color
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupClothingSizeTextField() {
        view.addSubview(clothingSizeTextField)
        let textField = UITextField()
        textField.placeholder = "Размер"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupClothingColorTextField() {
        view.addSubview(clothingColorTextField )
        let textField = UITextField()
        textField.placeholder = "Цвет"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupClothingBrandTextField() {
        view.addSubview(clothingBrandTextField)
        let textField = UITextField()
        textField.placeholder = "Брэнд"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40, width: 360, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    */
    
    // TODO: добавить место для фотографии imageView
    @objc private func didTapSelectPhotoButton() {
        // TODO: выбор фото
    }
    // TODO: Label отслеживания погоды
    // TODO: Выборку вариантов в Размер, Цвет и Брэнд
}

extension ClothesCreateViewController {
    func setConstraints() {
        NSLayoutConstraint.activate( [
            // Cloting name text field
            clothingNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            clothingNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Select photo button
            selectPhotoButton.topAnchor.constraint(equalTo: clothingNameTextField.topAnchor, constant: 60),
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
