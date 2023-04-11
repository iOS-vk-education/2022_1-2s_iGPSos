//
//  CustomButton.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 09.04.2023.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
       tintColor = ColorName.white.color
       backgroundColor = ColorName.mainPurple.color
       titleLabel?.font = FontFamily.Inter.medium.font(size: 22)
       layer.cornerRadius = 33
    }
}
