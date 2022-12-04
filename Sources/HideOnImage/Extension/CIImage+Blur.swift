//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit


extension CIImage {

    public func gaussianBlur(radius: CGFloat = 15) -> CIImage? {
        return CIFilter(
            name: FilterType.CIGuassianFilter.rawValue,
            parameters: [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: self,
            ]
        )?.outputImage
    }
    
    
    public enum FilterType: String {
        // TODO: - 추후 추가적인 필터 추가
        case CIGuassianFilter
    }
}

