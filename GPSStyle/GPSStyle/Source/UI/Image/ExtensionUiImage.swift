//
//  ExtensionUiImage.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 30.03.2023.
//

import UIKit
import CoreML
import CoreImage.CIFilterBuiltins

extension UIImage {
    func resize(size: CGSize? = nil, insets: UIEdgeInsets = .zero, fill: UIColor = .white) -> UIImage {
          var size: CGSize = size ?? self.size
          let widthRatio  = size.width / self.size.width
          let heightRatio = size.height / self.size.height
        
          if widthRatio > heightRatio {
            size = CGSize(width: floor(self.size.width * heightRatio), height: floor(self.size.height * heightRatio))
          } else if heightRatio > widthRatio {
            size = CGSize(width: floor(self.size.width * widthRatio), height: floor(self.size.height * widthRatio))
          }
        
          let rect = CGRect(x: 0,
                            y: 0,
                            width: size.width + insets.left + insets.right,
                            height: size.height + insets.top + insets.bottom)
        
          UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        
          fill.setFill()
          UIGraphicsGetCurrentContext()?.fill(rect)
        
          draw(in: CGRect(x: insets.left,
                          y: insets.top,
                          width: size.width,
                          height: size.height))
          let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
          UIGraphicsEndImageContext()
        
          return newImage!
        }
    
    func removeBackgroudIfPosible() -> UIImage? {
        let resizedImage: UIImage = resize(size: .init(width: 320, height: 320))
        
        guard
            let resizedCGImage = resizedImage.cgImage,
            let originalCGImage = cgImage,
            let mlModel = try? u2netp(),
            let resultMask = try? mlModel.prediction(input: u2netpInput(in_0With: resizedCGImage)).out_p1 else {
            return nil
        }
        
        let originalImage = CIImage(cgImage: originalCGImage)
        var maskImage = CIImage(cvPixelBuffer: resultMask)
        
        let scaleX = originalImage.extent.width / maskImage.extent.width
        let scaleY = originalImage.extent.height / maskImage.extent.height
        maskImage = maskImage.transformed(by: .init(scaleX: scaleX, y: scaleY))
        
        let context = CIContext(options: nil)
        
        guard let inputCGImage = context.createCGImage(originalImage, from: originalImage.extent) else {
            return nil
        }
        
        let blendFilter = CIFilter.blendWithRedMask()
        
        blendFilter.inputImage = CIImage(cgImage: inputCGImage)
        blendFilter.maskImage = maskImage
        
        guard let outputCIImage = blendFilter.outputImage?.oriented(.up),
              let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: outputCGImage)
    }
}
