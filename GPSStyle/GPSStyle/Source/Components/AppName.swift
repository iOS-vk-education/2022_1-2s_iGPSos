//
//  AppName.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 23.10.2022.
//

import Foundation
import UIKit

final class AppName: UILabel {
    private let theme: AppNameTheme

    public enum AppNameTheme {
        case normal
    }
    init (theme: AppNameTheme = .normal){
        self.theme = theme
        super.init(frame: .zero)
        
    }
    
    required init?(coder decoder: NSCoder) {
        self.theme = .normal
        super.init(coder: decoder)
    }
}
