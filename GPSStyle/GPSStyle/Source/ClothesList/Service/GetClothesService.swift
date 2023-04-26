//
//  GetClothesService.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 24.12.2022.
//

import Firebase

protocol GetClothesServiceInput: AnyObject {
    func fetchClothing()
    func delClothing(clth: ClothingModel)
}

protocol GetClothesServiceOutput: AnyObject {
    func faild()
    func success(with array: [ClothesSection])
}

final class GetClothesService {
    private let database = Firestore.firestore()
    weak var output: GetClothesServiceOutput?
    
    init(interactor: GetClothesServiceOutput?) {
        output = interactor
    }
}

extension GetClothesService: GetClothesServiceInput {
    func fetchClothing() {
        database.collection("clothes").whereField(
            "userId", isEqualTo: Auth.auth().currentUser?.uid ?? ""
        ).getDocuments { [weak self] querySnapshot, error in
            if error != nil {
                self?.output?.faild()
                return
            }
            guard let documents = querySnapshot?.documents else {
                self?.output?.faild()
                return
            }
            
            let clothes = documents.map { snapshot -> ClothingModel in
                let data = snapshot.data()
                let dataSpectification = data["specification"] as? [String: String] ?? [:]
                let specification = SpecificationModel.init(brand: dataSpectification["brand"] ?? "",
                                                            category: dataSpectification["category"] ?? "",
                                                            size: dataSpectification["size"] ?? "")
                return ClothingModel(
                    uuid: data["uuid"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    imageName: data["imageName"] as? String ?? "",
                    specification: specification
                )
            }.compactMap { $0 }
            
            let categoryModels: [ClothingModel] = clothes.sorted { $0.specification.category < $1.specification.category }
            let allCategories: [String] = categoryModels.map { $0.specification.category }
            let categories: [String] = Array(Set(allCategories))
            
            let clothesSections: [ClothesSection] = categories.compactMap { item in
                var clothesRows: [ClothesRow] = []
                _ = categoryModels.map {
                    if item == $0.specification.category {
                        let row = ClothesRow.init(id: $0.uuid,
                                                  title: $0.name,
                                                  imageUrl: $0.imageName,
                                                  isWarning: false,
                                                  specification: $0.specification)
                        clothesRows.append(row)
                    }
                }
                return ClothesSection.init(title: item, rows: clothesRows)
            }
            self?.output?.success(with: clothesSections)
        }
    }
    
    func delClothing(clth: ClothingModel) {
        database.collection("clothes").whereField(
            "uuid", isEqualTo: clth.uuid ).getDocuments { [weak self] querySnapshot, error in
            if error != nil {
                self?.output?.faild()
                return
            }
            guard let documents = querySnapshot?.documents else {
                self?.output?.faild()
                return
            }
            
            _ = documents.map { snapshot -> ClothingModel in
                let data = snapshot.data()
                return ClothingModel(
                    uuid: data["uuid"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    imageName: data["imageName"] as? String ?? "",
                    specification: data["specification"] as? SpecificationModel ?? SpecificationModel.init(brand: "",
                                                                                                           category: "",
                                                                                                           size: "")
                )
            }.compactMap { $0 }
            
            for clothes in querySnapshot!.documents {
                clothes.reference.delete { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document Clth successfully removed!")
                    }
                }
            }
        }
    }
}
