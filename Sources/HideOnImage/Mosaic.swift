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
    public var detectBoundInfo: [CGRect]
    
    // MARK: - Initializers
    public init() {
        self.faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: handleDetectedFaces)
        self.detectBoundInfo = []
    }
    
}
