//
//  CreateLookService.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 24.11.2021.
//

import Firebase

protocol CreateLookServiceInput: AnyObject {
    func createLook(with title: String?, images: [String], and clothId: [String])
}

protocol CreateLookServiceOutput: AnyObject {
    func faild()
    func success()
}

final class CreateLookService {
    private let database = Firestore.firestore()
    weak var output: CreateLookServiceOutput?
    
    init(interactor: CreateLookServiceOutput?) {
        output = interactor
    }
}

extension CreateLookService: CreateLookServiceInput {
    func createLook(with title: String?, images: [String], and clothId: [String]) {
        var dict = [String: Any]()
        
        dict["clothId"] = clothId
        dict["images"] = images
        dict["title"] = title
        dict["uuid"] = UUID().uuidString
        dict["userId"] = Auth.auth().currentUser?.uid
        database.collection("looks").addDocument(data: dict) { [weak self] error in
            if error != nil {
                self?.output?.faild()
            } else {
                self?.output?.success()
            }
        }
    }
}
