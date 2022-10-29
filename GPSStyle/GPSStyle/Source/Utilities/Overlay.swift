//
//  Overlay.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 29.10.2022.
//

import UIKit

extension UIView {
    func addoverlay(color: UIColor = ColorName.darkGrey.color, alpha: CGFloat = 0.1) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
}
