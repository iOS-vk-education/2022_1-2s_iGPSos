//
//  PickerTextField.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 19.11.2022.
//

import Foundation
import UIKit

typealias PickerTextFieldDisplayNameHandler = ((Any) -> String)
typealias PickerTextFieldItemSelectionHandler = ((Int, Any) -> Void)

final class CustomPickerTextField: UITextField {
    private let pickerView = UIPickerView(frame: .zero)
    private var lastSelectedRow: Int?
    
    public var pickerDatas: [Any] = []
    public var displayNameHandler: PickerTextFieldDisplayNameHandler?
    public var itemSelectionHandler: PickerTextFieldItemSelectionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    private func configureView() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.inputView = self.pickerView
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(self.doneButtonTapped))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        self.inputAccessoryView = toolbar
    }
    
    private func updateText() {
        if self.lastSelectedRow == nil {
            self.lastSelectedRow = 0
        }
        if self.lastSelectedRow! > self.pickerDatas.count {
            return
        }
        let data = self.pickerDatas[lastSelectedRow!]
        self.text = self.displayNameHandler?(data)
    }
                                         
    @objc func doneButtonTapped() {
        updateText()
        resignFirstResponder()
    }
}

extension CustomPickerTextField: UIPickerViewDelegate {
    func pickerView(_ pickView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = self.pickerDatas[row]
        return self.displayNameHandler?(data)
    }
}

extension CustomPickerTextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDatas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectionRow row: Int, inComponent component: Int) {
        self.lastSelectedRow = row
        self.updateText()
        let data = self.pickerDatas[row]
        self.itemSelectionHandler?(row, data)
    }
}
