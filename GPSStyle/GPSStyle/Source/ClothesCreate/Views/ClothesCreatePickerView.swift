//
//  ClothesCreatePickerView.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 21.12.2022.
//

import UIKit
import PinLayout

final class ClothesCreatePickerViewController: UIViewController {
    private let nameOfPicker: UILabel = UILabel()
    private let pickerView: UIPickerView = UIPickerView()
    private let buttonSelect: UIButton = UIButton()
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        nameOfPicker.text = "NAME OF PICKER"
        nameOfPicker.textAlignment = .center
        nameOfPicker.font = UIFont(name: "Avenir Next", size: 22.0)
        
        buttonSelect.setTitle("Select", for: .normal)
        buttonSelect.backgroundColor = .purple
        buttonSelect.layer.cornerRadius = 40 / 2
        
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
    
    func configure(with model: pickerViewUnitCreateClothes) {
        nameOfPicker.text = model.name
        data = model.variants
    }
}

extension ClothesCreatePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
