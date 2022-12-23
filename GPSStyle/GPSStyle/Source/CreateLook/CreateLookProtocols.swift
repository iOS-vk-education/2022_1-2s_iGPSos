//
//  CreateLookProtocols.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 22.11.2022.
//  
//

import Foundation

protocol CreateLookModuleInput {
	var moduleOutput: CreateLookModuleOutput? { get }
}

protocol CreateLookModuleOutput: AnyObject {
}

protocol CreateLookViewInput: AnyObject {
    func reloadData()
}

protocol CreateLookViewOutput: AnyObject {
    func viewDidLoad()
    func getCloth(index: Int) -> ClothesLookCreate
    var countList: Int { get }
    func updateIsSelected(index: Int)
    func createLook(with title: String?)
}

protocol CreateLookInteractorInput: AnyObject {
    func createLook(with title: String?, images: [String], and clothId: [String])
    func fetchCloths()
}

protocol CreateLookInteractorOutput: AnyObject {
    func finishCreatingLook()
    func clothDidLoad(with array: [ClothesLookCreate])
}

protocol CreateLookRouterInput: AnyObject {
    func closeVC()
}
