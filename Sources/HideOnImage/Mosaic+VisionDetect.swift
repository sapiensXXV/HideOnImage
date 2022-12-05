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
    public func convert(with image: UIImage?, type: ConvertType = .vision) {
        print(#function)
        guard let image = image,
              let cgImage = image.cgImage,
              let ciImage = CIImage(image: image) else {
            print("Can not find UIImage")
            return
        }
        self.currentImage = image
        let cgOrientation = CGImagePropertyOrientation(image.imageOrientation)
        
        switch type {
        case .vision:
            startVisionRequest(image: cgImage, orientation: cgOrientation)
            
        case .ciDetector:
            startCIDetect(ciImage: ciImage, orientation: cgOrientation)
        }
        
        
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
