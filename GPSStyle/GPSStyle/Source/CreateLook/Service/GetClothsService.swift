//
//  GetClothsService.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 24.11.2021.
//

import Firebase

protocol GetClothsServiceInput: AnyObject {
    func fetchCloth()
}

protocol GetClothsServiceOutput: AnyObject {
    func faild()
    func success(with array: [ClothesLookCreate])
}

final class GetClothsService {
    private let database = Firestore.firestore()
    weak var output: GetClothsServiceOutput?
    
    init(interactor: GetClothsServiceOutput?) {
        output = interactor
    }
}

extension GetClothsService: GetClothsServiceInput {
    func fetchCloth() {
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
            
            let clothes = documents.map { snapshot -> ClothesLookCreate? in
                let data = snapshot.data()
                var specifications = [Specification]()
                guard let specificationsDict = data["specification"] as? NSMutableDictionary  else { return nil }
               
                for d in specificationsDict {
                    specifications.append(
                        Specification(
                            type: d.key as? String ?? "",
                            value: d.value as? String ?? ""
                        )
                    )
                }
                
                return ClothesLookCreate(
                    isSelected: false,
                    uuid: data["uuid"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    imageName: data["imageName"] as? String ?? "",
                    specification: specifications
                )
            }.compactMap { $0 }
            self?.output?.success(with: clothes)
        }
    }
}
