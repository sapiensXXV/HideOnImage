//
//  MosaicConfiguration.swift
//  
//
//  Created by Jaehoon So on 2023/01/14.
//

import Foundation

public struct MosaicConfiguration {
    public var aiType: AIType = .vision
    public var radius: CGFloat = 15
}

public enum AIType {
    case vision
    case ciDetector
}
