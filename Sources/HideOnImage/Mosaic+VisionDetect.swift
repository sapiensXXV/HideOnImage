//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit
import CoreML
import Vision


extension Mosaic {
    public func convert(with image: UIImage?) {
        guard let image = image,
              let cgImage = image.cgImage else {
            print("Can not find UIImage")
            return
        }
        self.currentImage = image
        let cgOrientation = CGImagePropertyOrientation(image.imageOrientation)
        startVisionRequest(image: cgImage, orientation: cgOrientation)
    }
    
    public func startVisionRequest(image: CGImage, orientation: CGImagePropertyOrientation) {
        let requests = createVisionRequest()
        let imageRequestHandler = VNImageRequestHandler(
            cgImage: image,
            orientation: orientation,
            options: [:]
        )
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(requests)
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        
    }
    
    public func createVisionRequest() -> [VNRequest] {
        var requests: [VNRequest] = []
        requests.append(faceDetectionRequest)
        return requests
    }
    
    public func addDetectInfo(bound: CGRect) {
        guard let image = currentImage else { return }
        
        let width = image.size.width * bound.size.width
        let height = image.size.height * bound.size.height
        let xCoordinate = image.size.width * bound.origin.x
        let yCoordinate = (image.size.height * (1 - bound.origin.y)) - height
        
        let rect = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
        
        self.detectBoundInfo.append(rect)
    }
}
