//
//  CreateClothesService.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 24.12.2022.
//

import Firebase
import FirebaseStorage

protocol CreateClothesServiceInput: AnyObject {
    func createClothes(model: ClothesModel)
}

protocol CreateClothesServiceOutput: AnyObject {
    func faild()
    func success()
}

final class CreateClothesService {
    private let database = Firestore.firestore()
    weak var output: CreateLookServiceOutput?
    private let storage = Storage.storage().reference()
    
    init(interactor: CreateLookServiceOutput?) {
        output = interactor
    }
}

extension CreateClothesService: CreateClothesServiceInput {
    func createClothes(model: ClothesModel) {
        // Data in memory
        guard let data = model.image.jpegData(compressionQuality: 1.0) else {
            return
        }
        let imageName = UUID().uuidString
        // Create a reference to the file you want to upload
        let riversRef = storage.child("\(imageName).jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data, metadata: nil) { [weak self] (_, _) in
            var specificationDict = [String: Any]()
            specificationDict["category"] = model.specification.category
            specificationDict["brand"] = model.specification.brand
            specificationDict["size"] = model.specification.size
            var dict = [String: Any]()
            
            dict["imageName"] = "\(imageName).jpg"
            dict["name"] = model.title
            dict["specification"] = specificationDict
            dict["checkWeather"] = model.checkWeather
            dict["uuid"] = UUID().uuidString
            dict["userId"] = Auth.auth().currentUser?.uid
            self?.database.collection("clothes").addDocument(data: dict) { [weak self] error in
                if error != nil {
                    self?.output?.faild()
                } else {
                    self?.output?.success()
                }
            }
        }
    }
}
