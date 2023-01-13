//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit


public protocol MosaicProtocol {

    var delegate: MosaicDelegate? { get set }
    func convert(uiImage: UIImage?)
    func convert(cgImage: CGImage?)
    func convert(ciImage: CIImage?)
}

public protocol MosaicDelegate {
    
    func mosaicImageProcessDidFinish(with result: UIImage)
    
}
