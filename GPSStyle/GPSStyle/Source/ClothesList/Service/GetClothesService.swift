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
    func success(with array: [ClothingModel])
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
                return ClothingModel(
                    uuid: data["uuid"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    imageName: data["imageName"] as? String ?? "",
                    specification: data["specification"] as? [String: String] ?? [:]
                )
            }.compactMap { $0 }
            self?.output?.success(with: clothes)
        }
    }
    
    func delClothing(clth: ClothingModel) {
        database.collection("clothes").document("JUayHtqIAlhfCRNAV4XH").delete { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
//        database.collection("clothes").document(clth.uuid).delete { error in
//                           if let error = error {
//                               print(error.localizedDescription)
//                           } else {
//                               print("File deleted successfully")
//                           }
//                       }
//           }
//    }
//        database.collection("clothes").document(clth.uuid).delete { error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    } else {
//                        print("File deleted successfully")
//                    }
//                }
//    }
}
