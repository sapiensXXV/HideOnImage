//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit


extension CIImage {

    public func gaussianBlur(radius: CGFloat) -> CIImage? {
        return CIFilter(
            name: FilterType.CIGaussianBlur.rawValue,
            parameters: [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: self,
            ]
        )?.outputImage
    }
    
    public func maskSelectedBound(_ bounds: [CGRect]) -> CIImage? {
        // 블러될 영역에 마스크를 씌우고, 블러처리한 이미지와 합쳐서 결과물로 선택된 영역만 모자이크 처리된 이미지를 얻게 된다.
        
        var maskImage = CIImage?.none
        
        bounds.forEach {
            let width = $0.size.width
            let height = $0.size.height
            let xCenterCoordinate = $0.origin.x + (width / 2)
            let yCenterCoordinate = (extent.height - $0.maxY) + (height / 2)
            let radius = min(width, height) / 1.7
            
            let areaImage = CIFilter(
                name: FilterType.CIRadialGradient.rawValue,
                parameters: [
                    kCIInputCenterKey: CIVector(x: xCenterCoordinate, y: yCenterCoordinate),
                    "inputRadius0": NSNumber(value: radius),
                    "inputRadius1": NSNumber(value: radius + 1),
                    "inputColor0": CIColor(red: .zero, green: 1, blue: 0, alpha: 1),
                    "inputColor1": CIColor(color: .clear)
                ]
            )?.outputImage
            
            guard let backgroundImage = maskImage,
                  let areaImage else {
                maskImage = areaImage
                return
            }
            
            maskImage = CIFilter(
                name: FilterType.CISourceOverCompositing.rawValue,
                parameters: [
                    kCIInputImageKey: areaImage,
                    kCIInputBackgroundImageKey: backgroundImage
                ]
            )?.outputImage
        }
        
        return maskImage
    }
    
    public func combineMosaicAndMask(maskImage: CIImage, mosaicImage: CIImage) -> CIImage? {
        return CIFilter(
            name: FilterType.CIBlendWithMask.rawValue,
            parameters: [
                kCIInputImageKey: mosaicImage,
                kCIInputBackgroundImageKey: self,
                kCIInputMaskImageKey: maskImage
            ]
        )?.outputImage
    }
    
}

