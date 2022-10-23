//
//  MainAuthViewController.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 23.10.2022.
//

import Foundation
import UIKit
import Firebase

class MainAuthViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "GPStyle"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
    }
    
}


