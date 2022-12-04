//
//  File.swift
//  
//
//  Created by Jaehoon So on 2022/12/04.
//

import Vision


// MARK: - Handler

extension Mosaic {
    public func handleDetectedFaces(request: VNRequest?, error: Error?) {
        if let error = error {
            // TODO: - 커스텀 에러 처리
            print(error.localizedDescription)
            return
        }
        
        // 감지된 정보를 정제해서 Mosaic클래스의 detectBoundInfo에 삽입한다.
        guard let results = request?.results as? [VNFaceObservation] else {
            // TODO: - 커스텀 에러 처리
            return
        }
        
        results.forEach { observation in
            let bound = observation.boundingBox
            self.addDetectInfo(bound: bound)
        }
        
        // 이미지를 처리해서 delegate 메서드로 전달한다.
        applyMosaic()
    }
}
