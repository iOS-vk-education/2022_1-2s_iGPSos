//
//  Button.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 23.10.2022.
//

import Foundation
import UIKit

final class MainButton: UIButton {
    struct MainButtonUIConstants {
        static let iconMargin: CGFloat = 10
        static let cornerRadius: CGFloat = 14
        static let loaderHeight: CGFloat = 20
        static let loaderMargin: CGFloat = 10
        static let loaderLineWidth: CGFloat = 3
    }
    
    public enum ButtonTheme {
        case action //Create account
        case clear //Already have account
    }
}

    
