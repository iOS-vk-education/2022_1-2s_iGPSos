//
//  ImageLoader.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 29.10.2022.
//

import UIKit.UIImage
import FirebaseStorage

final class ImageLoader {
    public static let shared = ImageLoader()
    
    private let cache: ImageCacheType
    
    private init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    private let storage = Storage.storage().reference()
    
    func image(hash: Int, with name: String, completion: @escaping (Int, UIImage?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let image = self?.cache[name] {
                completion(hash, image)
                return
            }
            self?.storage.child(name).getData(maxSize: 15 * 1024 * 1024) { data, error in
                if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    self?.cache[name] = image
                    completion(hash, image)
                    return
                } else {
                    completion(hash, nil)
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
}
