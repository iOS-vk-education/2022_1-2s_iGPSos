//
//  ClothesCreateViewController.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 29.10.2022.
//

import UIKit

final class ClothesCreateViewController: UIViewController, ClothesCreatePickerDelegate {
    private enum Constants {
        static let layerCornerRadius:  CGFloat = 30.0
        static let layerShadowRadius:  CGFloat = 2.0
        static let layerShadowOpacity: Float = 0.2
        static let shadowOffsetHeight: CGFloat = 5.0
        static let shadowOffsetWidth:  CGFloat = 0.0
        static let specficationsElementsTop:     CGFloat = 10.0
        static let specficationsElementshHeight: CGFloat = 56.0
        static let specficationsViewElementsLeading:   CGFloat = 10.0
        static let specficationsViewElementsTrailing:  CGFloat = -10.0
        static let specficationsLabelElementsLeading:  CGFloat = 40.0
        static let specficationsLabelElementsTrailing: CGFloat = -40.0
        static let elementsTop:       CGFloat = 15.0
        static let buttonHeight:      CGFloat = 60.0
        static let buttonLeading:     CGFloat = 70.0
        static let buttonTrailing:    CGFloat = -70.0
        static let imageViewHeight:   CGFloat = 180.0
        static let imageViewLeading:  CGFloat = 107.0
        static let imageViewTrailing: CGFloat = -107.0
        static let pickerDrumHeight:  CGFloat = 300.0
    }
    
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
        textField.layer.cornerRadius = Constants.layerCornerRadius
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        
        textField.borderStyle = .none
        textField.leftViewMode = .always
        textField.layer.shadowColor = UIColor.gray.cgColor
        
        textField.layer.shadowOffset = CGSize(width: Constants.shadowOffsetWidth, height: Constants.shadowOffsetHeight)
        textField.layer.shadowRadius = Constants.layerShadowRadius
        textField.layer.shadowOpacity = Constants.layerShadowOpacity
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let clothesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.layerCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var selectPhotoButton: CustomButton = CustomButton()
    
    private lazy var clothingSizeView: UIView = {
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
    
    private let clothingSizeLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.size
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clothingCategoryView: UIView = {
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
    
    private let clothingColorCategoryLabel: UILabel = {
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
        view.layer.cornerRadius = Constants.layerCornerRadius
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: Constants.shadowOffsetWidth, height: Constants.shadowOffsetHeight)
        view.layer.shadowRadius = Constants.layerShadowRadius
        view.layer.shadowOpacity = Constants.layerShadowOpacity
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let clothingBrandLabel: UILabel = {
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
                         clothingSizeLabel,
                         clothingCategoryView,
                         clothingColorCategoryLabel,
                         clothingBrandView,
                         clothingBrandLabel,
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
        clothingSizeLabel.addGestureRecognizer(recognierSize)
        
        let recognierCategory = UITapGestureRecognizer(target: self, action: #selector(didTapColorLabel))
        clothingColorCategoryLabel.addGestureRecognizer(recognierCategory)
        
        let recognierBrand = UITapGestureRecognizer(target: self, action: #selector(didTapBrandLabel))
        clothingBrandLabel.addGestureRecognizer(recognierBrand)
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
            nav.detents = [.custom { _ in return Constants.pickerDrumHeight }]
        }
        present(nav, animated: true)
    }
    
    func didFinishPicking(with model: UnitClothesType) {
        switch model.typeName {
        case TypeName.brand:
            clothingBrandLabel.text = model.selectedValue
            clothingBrandLabel.textColor = .black
            specification[L10n.brand] = model.selectedValue
            pickerUnitClothesBrand = model
        case TypeName.category:
            clothingColorCategoryLabel.text = model.selectedValue
            clothingColorCategoryLabel.textColor = .black
            specification[L10n.category] = model.selectedValue
            pickerUnitClothesCategory = model
        case TypeName.size:
            clothingSizeLabel.text = model.selectedValue
            clothingSizeLabel.textColor = .black
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
            clothingNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.elementsTop),
            clothingNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsViewElementsLeading),
            clothingNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsViewElementsTrailing),
            clothingNameTextField.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            clothesImageView.topAnchor.constraint(equalTo: clothingNameTextField.bottomAnchor, constant: Constants.elementsTop),
            clothesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageViewLeading),
            clothesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageViewTrailing),
            clothesImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            
            supportConstraint,
            selectPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonLeading),
            selectPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonTrailing),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            clothingSizeView.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: Constants.elementsTop),
            clothingSizeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsViewElementsLeading),
            clothingSizeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsViewElementsTrailing),
            clothingSizeView.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            clothingSizeLabel.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: Constants.elementsTop),
            clothingSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsLabelElementsLeading),
            clothingSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsLabelElementsTrailing),
            clothingSizeLabel.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            clothingCategoryView.topAnchor.constraint(equalTo: clothingSizeLabel.bottomAnchor, constant: Constants.specficationsElementsTop),
            clothingCategoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsViewElementsLeading),
            clothingCategoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsViewElementsTrailing),
            clothingCategoryView.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            clothingColorCategoryLabel.topAnchor.constraint(equalTo: clothingSizeLabel.bottomAnchor, constant: Constants.specficationsElementsTop),
            clothingColorCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsLabelElementsLeading),
            clothingColorCategoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsLabelElementsTrailing),
            clothingColorCategoryLabel.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            clothingBrandView.topAnchor.constraint(equalTo: clothingColorCategoryLabel.bottomAnchor, constant: Constants.specficationsViewElementsLeading),
            clothingBrandView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsViewElementsLeading),
            clothingBrandView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsViewElementsTrailing),
            clothingBrandView.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            clothingBrandLabel.topAnchor.constraint(equalTo: clothingColorCategoryLabel.bottomAnchor, constant: Constants.specficationsElementsTop),
            clothingBrandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.specficationsLabelElementsLeading),
            clothingBrandLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.specficationsLabelElementsTrailing),
            clothingBrandLabel.heightAnchor.constraint(equalToConstant: Constants.specficationsElementshHeight),
            
            cretateClothesButton.topAnchor.constraint(equalTo: clothingBrandLabel.bottomAnchor, constant: Constants.specficationsElementsTop),
            cretateClothesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonLeading),
            cretateClothesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.buttonTrailing),
            cretateClothesButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ] )
    }
    
    private func updateConstraints() {
        supportConstraint?.isActive = false
        supportConstraint = clothesImageView.image == nil ?
        selectPhotoButton.topAnchor.constraint(equalTo: clothingNameTextField.bottomAnchor, constant: Constants.elementsTop) :
        selectPhotoButton.topAnchor.constraint(equalTo: clothesImageView.bottomAnchor, constant: Constants.elementsTop)
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
