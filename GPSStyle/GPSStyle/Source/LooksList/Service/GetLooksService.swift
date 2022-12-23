//
//  GetLooksService.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 24.12.2022.
//

import Firebase

protocol GetLooksServiceInput: AnyObject {
    func fetchLooks()
}

protocol GetLooksServiceOutput: AnyObject {
    func faild()
    func success(with array: [LookModel])
}

final class GetLooksService {
    private let database = Firestore.firestore()
    weak var output: GetLooksServiceOutput?
    
    init(interactor: GetLooksServiceOutput?) {
        output = interactor
    }
}

extension GetLooksService: GetLooksServiceInput {
    func fetchLooks() {
        database.collection("looks").whereField(
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
            
            let looks = documents.map { snapshot -> LookModel in
                let data = snapshot.data()
                return LookModel(
                    uuid: data["uuid"] as? String ?? "",
                    name: data["title"] as? String ?? "",
                    imageName: data["images"] as? [String] ?? []
                )
            }.compactMap { $0 }
            self?.output?.success(with: looks)
        }
    }
}
