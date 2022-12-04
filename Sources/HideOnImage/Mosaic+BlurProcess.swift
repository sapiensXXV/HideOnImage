//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit


extension Mosaic {
//    public func applyFsdfilter() {
//        guard let ciImage = CIImage(image: image),
//              let blurredImage = ciImage.gaussianBlur(),
//              let maskImage = ciImage.maskAreas(selectedFaceRects),
//              let blendedImage = ciImage.blendWithMask(maskImage, inputImage: blurredImage),
//              let cgImage = BlurredImageViewModel.context.createCGImage(
//                blendedImage,
//                from: blendedImage.extent
//              )
//        else {
//            blurCompletionHandler?(nil)
//            return
//        }
//
//        blurCompletionHandler?(UIImage(cgImage: cgImage))
//    }
    
    public func applyMosaic() {
        guard let image = self.currentImage,
              !detectBoundInfo.isEmpty else {
            // TODO: - 에러처리, 감지된 얼굴 없음 알림 등
            return
        }
        
        guard let ciImage = CIImage(image: image),
              let mosaicImage = ciImage.gaussianBlur() else {
            // TODO: - 이미지처리 실패 에러
            return
        }
        
        let completeImage = UIImage(ciImage: mosaicImage)
        delegate?.MosaicImageProcessDidFinish(with: completeImage)
    }
    
}
