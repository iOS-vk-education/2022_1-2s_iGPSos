//
//  LooksListViewController.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.10.2022.
//  
//

import UIKit

final class LooksListViewController: UIViewController {
	private let output: LooksListViewOutput

    init(output: LooksListViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .blue // [art] to detect loaded ViewController from SceneDelegate
	}
}

extension LooksListViewController: LooksListViewInput {
}
