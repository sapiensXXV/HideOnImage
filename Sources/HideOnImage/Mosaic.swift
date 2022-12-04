//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit
import CoreML
import Vision


public final class Mosaic: MosaicProtocol {
    
    // MARK: - Properties
    public lazy var faceDetectionRequest: VNDetectFaceRectanglesRequest?
        = VNDetectFaceRectanglesRequest(completionHandler: handleDetectedFaces)
    public static let context = CIContext()
    public var detectBoundInfo: [CGRect]
    public var currentImage: UIImage?
    public var delegate: MosaicDelegate?
    
    // MARK: - Initializers
    public init() {
        self.detectBoundInfo = []
    }
    
}
