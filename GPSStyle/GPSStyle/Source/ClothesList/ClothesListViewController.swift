//
//  ClothesListViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class ClothesListViewController: UIViewController {
	private let output: ClothesListViewOutput

    init(output: ClothesListViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .yellow // [art] to detect loaded ViewController from SceneDelegate
	}
}

extension ClothesListViewController: ClothesListViewInput {
}
