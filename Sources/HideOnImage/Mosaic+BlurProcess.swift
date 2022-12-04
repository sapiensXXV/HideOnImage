//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit


extension Mosaic {
    
    public func applyMosaic() {
        guard let image = self.currentImage,
              !detectBoundInfo.isEmpty else {
            // TODO: - 에러처리, 감지된 얼굴 없음 알림 등
            print("감지된 얼굴이 없습니다.")
            return
        }
        
        guard let ciImage = CIImage(image: image),
              let mosaicImage = ciImage.gaussianBlur(),
              let maskImage = ciImage.maskSelectedBound(detectBoundInfo),
              let combinedImage = ciImage.combineMosaicAndMask(maskImage: maskImage, mosaicImage: mosaicImage),
              let cgImage = Mosaic.context.createCGImage(
                combinedImage,
                from: combinedImage.extent
              )
        else {
            // TODO: - 이미지처리 실패 에러
            return
        }
        
        let completeImage = UIImage(cgImage: cgImage)
        delegate?.mosaicImageProcessDidFinish(with: completeImage)
    }
    
}
