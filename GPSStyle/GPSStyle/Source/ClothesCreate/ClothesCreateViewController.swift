//
//  ClothesCreateViewController.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateViewController: UIViewController, ClothesCreatePickerDelegate {
    private let output: ClothesCreateViewOutput
    
    private var supportConstraint: NSLayoutConstraint?
    
    private var checkTheWeather: Bool = false
    
    private var specification: [String: String] = [:]
    
    private var pickerUnitClothesBrand = UnitClothesType(name: L10n.brand,
                                                         variants: clothesBrand,
                                                         typeName: TypeName.brand,
                                                         selectedValue: nil)
    private var pickerUnitClothesCategory = UnitClothesType(name: L10n.category,
                                                            variants: clothesCategory,
                                                            typeName: TypeName.category,
                                                            selectedValue: nil)
    private var pickerUnitClothesSize = UnitClothesType(name: L10n.size,
                                                        variants: clothesSize,
                                                        typeName: TypeName.size,
                                                        selectedValue: nil)
    
    private let clothingNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.clothesName
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 30
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        
        textField.borderStyle = .none
        textField.leftViewMode = .always
        textField.layer.shadowColor = UIColor.gray.cgColor
        
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowRadius = 2
        textField.layer.shadowOpacity = 0.2
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
    
    private var selectPhotoButton: CustomButton = CustomButton()
    
    private lazy var clothingSizeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let clothingSizeTextField: UILabel = {
        let label = UILabel()
        label.text = L10n.size
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clothingColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let clothingColorTextField: UILabel = {
        let label = UILabel()
        label.text = L10n.category
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clothingBrandView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let clothingBrandTextField: UILabel = {
        let label = UILabel()
        label.text = L10n.brand
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var cretateClothesButton: CustomButton = CustomButton()
    
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
                         clothingSizeView,
                         clothingSizeTextField,
                         clothingColorView,
                         clothingColorTextField,
                         clothingBrandView,
                         clothingBrandTextField,
                         cretateClothesButton)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        selectPhotoButton.setTitle(L10n.addPhoto, for: .normal)
        selectPhotoButton.tintColor = ColorName.mainPurple.color
        selectPhotoButton.backgroundColor = ColorName.lightPink.color
        selectPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        cretateClothesButton.setTitle(L10n.createClothes, for: .normal)
        cretateClothesButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPickersViews() {
        let recognierSize = UITapGestureRecognizer(target: self, action: #selector(didTapSizeLabel))
        clothingSizeTextField.addGestureRecognizer(recognierSize)
        
        let recognierCategory = UITapGestureRecognizer(target: self, action: #selector(didTapColorLabel))
        clothingColorTextField.addGestureRecognizer(recognierCategory)
        
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
    
    private func didTapSpecificationLabel(unit: UnitClothesType) {
        let clothesCreatePickerViewController = ClothesCreatePickerViewController(model: unit)
        clothesCreatePickerViewController.delegate = self
        let nav = UINavigationController(rootViewController: clothesCreatePickerViewController)
        nav.modalPresentationStyle = .pageSheet
        if let nav = nav.presentationController as? UISheetPresentationController {
            nav.prefersGrabberVisible = true
            nav.detents = [.custom { _ in return 300 }]
        }
        present(nav, animated: true)
    }
    
    func didFinishPicking(with model: UnitClothesType) {
        switch model.typeName {
        case TypeName.brand:
            clothingBrandTextField.text = model.selectedValue
            clothingBrandTextField.textColor = .black
            specification[L10n.brand] = model.selectedValue
            pickerUnitClothesBrand = model
        case TypeName.category:
            clothingColorTextField.text = model.selectedValue
            clothingColorTextField.textColor = .black
            specification[L10n.color] = model.selectedValue
            pickerUnitClothesCategory = model
        case TypeName.size:
            clothingSizeTextField.text = model.selectedValue
            clothingSizeTextField.textColor = .black
            specification[L10n.size] = model.selectedValue
            pickerUnitClothesSize = model
        }
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
    private func didTapCreateClothes() {
        guard let name = clothingNameTextField.text, !name.isEmpty,
              let image = clothesImageView.image,
              let size = pickerUnitClothesSize.selectedValue,
              let category = pickerUnitClothesCategory.selectedValue,
              let brand = pickerUnitClothesBrand.selectedValue
        else {
            return
        }
        output.didTapCreateClothes(model: ClothesModel(title: name,
                                                       image: image,
                                                       checkWeather: checkTheWeather,
                                                       specification: specification)) }
    @objc
    private func didTapSizeLabel() {
        didTapSpecificationLabel(unit: pickerUnitClothesSize)
    }
    
    @objc
    private func didTapColorLabel() {
        didTapSpecificationLabel(unit: pickerUnitClothesCategory)
    }
    
    @objc
    private func didTapBrandLabel() {
        didTapSpecificationLabel(unit: pickerUnitClothesBrand)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ClothesCreateViewController {
    private func setConstraints() {
        updateConstraints()
        guard let supportConstraint = supportConstraint else {
            return
        }
        NSLayoutConstraint.activate([
            clothingNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            clothingNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingNameTextField.heightAnchor.constraint(equalToConstant: 56),
            
            clothesImageView.topAnchor.constraint(equalTo: clothingNameTextField.bottomAnchor, constant: 15),
            clothesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 107),
            clothesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -107),
            clothesImageView.heightAnchor.constraint(equalToConstant: 180),
            
            supportConstraint,
            selectPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            selectPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 60),
            
            clothingSizeView.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 15),
            clothingSizeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingSizeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingSizeView.heightAnchor.constraint(equalToConstant: 56),
            
            clothingSizeTextField.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 15),
            clothingSizeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            clothingSizeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            clothingSizeTextField.heightAnchor.constraint(equalToConstant: 56),
            
            clothingColorView.topAnchor.constraint(equalTo: clothingSizeTextField.bottomAnchor, constant: 10),
            clothingColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingColorView.heightAnchor.constraint(equalToConstant: 56),
            
            clothingColorTextField.topAnchor.constraint(equalTo: clothingSizeTextField.bottomAnchor, constant: 10),
            clothingColorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            clothingColorTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            clothingColorTextField.heightAnchor.constraint(equalToConstant: 56),
            
            clothingBrandView.topAnchor.constraint(equalTo: clothingColorTextField.bottomAnchor, constant: 10),
            clothingBrandView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            clothingBrandView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            clothingBrandView.heightAnchor.constraint(equalToConstant: 56),
            
            clothingBrandTextField.topAnchor.constraint(equalTo: clothingColorTextField.bottomAnchor, constant: 10),
            clothingBrandTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            clothingBrandTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            clothingBrandTextField.heightAnchor.constraint(equalToConstant: 56),
            
            cretateClothesButton.topAnchor.constraint(equalTo: clothingBrandTextField.bottomAnchor, constant: 10),
            cretateClothesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            cretateClothesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
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
        
        if clothesImageView.image != nil {
            actionSheet.addAction(UIAlertAction(title: L10n.deletePhoto,
                                                style: .default,
                                                handler: { [weak self] _ in self?.deletePhoto()
            }))
        }
        
        present(actionSheet, animated: true)
    }
    
    private func deletePhoto() {
        self.clothesImageView.image = nil
        selectPhotoButton.setTitle(L10n.addPhoto, for: .normal)
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
        let resizeSelectedImage: UIImage = selectedImage.resize()
        let imageWithoutBackground: UIImage? = resizeSelectedImage.removeBackgroudIfPosible(width: 320, height: 320)
        self.clothesImageView.image = imageWithoutBackground
        if clothesImageView.image != nil {
            selectPhotoButton.setTitle(L10n.changePhoto, for: .normal)
        } else {
            selectPhotoButton.setTitle(L10n.addPhoto, for: .normal)
        }
        updateConstraints()
    }
}
