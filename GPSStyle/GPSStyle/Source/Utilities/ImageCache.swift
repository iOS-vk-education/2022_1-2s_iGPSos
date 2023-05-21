//
//  ImageCacheType.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 29.10.2022.
//

import Foundation
import UIKit.UIImage

public protocol ImageCacheType: AnyObject {
    func image(for url: String) -> UIImage?
    func insertImage(_ image: UIImage?, for url: String)
    subscript(_ url: String) -> UIImage? { get set }
}

public final class ImageCache: ImageCacheType {
    public func image(for url: String) -> UIImage? {
        guard let fileCachePath = try? FileManager.default.url(
            for: .cachesDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: false).appendingPathComponent(url) else { return  nil}
        if let data = try? Data(contentsOf: fileCachePath) {
            guard let image = UIImage(data: data) else { return nil}
            return image
        }
        return nil
    }
    
    public func insertImage(_ image: UIImage?, for url: String) {
        guard let fileCachePath = try? FileManager.default.url(
            for: .cachesDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: false).appendingPathComponent(url) else { return }
        
        let resizeSelectedImage: UIImage = image?.resize() ?? UIImage()
        let imageWithoutBackground: UIImage? = resizeSelectedImage.removeBackgroudIfPosible(width: 320, height: 320)
        
        if let data = imageWithoutBackground?.pngData() {
            try? data.write(to: fileCachePath)
        }
    }
    
    public subscript(url: String) -> UIImage? {
        get {
            return self.image(for: url)
        }
        set {
            self.insertImage(newValue, for: url)
        }
    }
}
