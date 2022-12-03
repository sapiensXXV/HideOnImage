//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit
import CoreML
import Vision


public final class Mosaic {
    
    // MARK: - Properties
    
    public let faceDetectionRequest: VNDetectFaceRectanglesRequest?
    
    
    // MARK: - Initializers
    public init() {
        self.faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: handleDetectedFaces)
    }
    
}

extension Mosaic {
    public func convert(with image: UIImage?) {
        guard let image = image,
              let cgImage = image.cgImage else {
            print("Can not find UIImage")
            return
        }
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
        guard let faceDetectionRequest = faceDetectionRequest else {
            print("Failed to generate face detection request.")
            return []
        }
        return [faceDetectionRequest]
    }
}


