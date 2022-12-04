//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import UIKit


public protocol MosaicProtocol {
    
    var delegate: MosaicDelegate? { get set }
    
    func convert(with image: UIImage?)
}

public protocol MosaicDelegate {
    
    func mosaicImageProcessDidFinish(with result: UIImage)
    
}
