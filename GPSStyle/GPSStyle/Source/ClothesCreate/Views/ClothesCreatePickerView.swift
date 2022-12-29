//
//  ClothesCreatePickerView.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 21.12.2022.
//

import UIKit
import PinLayout

protocol ClothesCreatePickerDelegate: AnyObject {
    func didFinishPicking(with model: UnitClothesType)
}

final class ClothesCreatePickerViewController: UIViewController {
    private let nameOfPicker: UILabel = UILabel()
    private let pickerView: UIPickerView = UIPickerView()
    private let buttonSelect: UIButton = UIButton()
    private var model: UnitClothesType
    weak var delegate: ClothesCreatePickerDelegate?
    
    init(model: UnitClothesType) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        configure(with: model)
        
        nameOfPicker.textAlignment = .center
        nameOfPicker.font = UIFont(name: "Avenir Next", size: 22.0)
        
        buttonSelect.setTitle(L10n.selectCharacteristicButton, for: .normal)
        buttonSelect.backgroundColor = ColorName.mainPurple.color
        buttonSelect.layer.cornerRadius = 40 / 2
        buttonSelect.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubviews(nameOfPicker, pickerView, buttonSelect)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameOfPicker.pin
            .top()
            .marginTop(16)
            .horizontally()
            .sizeToFit(.width)
        
        buttonSelect.pin
            .bottom(view.safeAreaInsets.bottom)
            .height(40)
            .horizontally(16)
        
        pickerView.pin
            .marginTop(8)
            .marginBottom(8)
            .above(of: buttonSelect)
            .below(of: nameOfPicker)
            .horizontally()
    }
    
    func setSelectedValue(with model: UnitClothesType) {
        guard let selectedName = model.selectedValue,
              let rowSelectedValue = model.variants.firstIndex(of: selectedName) else {
            return
        }
        pickerView.selectRow(rowSelectedValue, inComponent: 0, animated: false)
    }
    
    private func configure(with model: UnitClothesType) {
        nameOfPicker.text = L10n.selectCharacteristic + model.name
        setSelectedValue(with: model)
    }
    
    @objc
    private func didTapSelectButton() {
        if model.selectedValue == nil {
            let newModel: UnitClothesType = UnitClothesType(name: model.name,
                                                            variants: model.variants,
                                                            typeName: model.typeName,
                                                            selectedValue: model.variants.first)
            self.model = newModel
        }
        delegate?.didFinishPicking(with: model)
        dismiss(animated: true)
    }
}

extension ClothesCreatePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        model.variants.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        model.variants[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let newModel: UnitClothesType = UnitClothesType(name: model.name,
                                                        variants: model.variants,
                                                        typeName: model.typeName,
                                                        selectedValue: model.variants[row])
        self.model = newModel
    }
}
