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
            print(error.localizedDescription)
//            delegate?.faceDetectDidFail()
            return
        }
        
        // 인식한 얼굴의 위치에 사각형을 그려주는 작업. 화면에 그리는 것이기 때문에 main thread에서 작업해야 함.
//        DispatchQueue.main.async {
//            guard let drawLayer = self.pathLayer,
//                  let results = request?.results as? [VNFaceObservation] else { return }
//            if results.isEmpty { self.delegate?.faceDetectCountZero() } // 인식된 얼굴이 없을 때 delegate메서드 호출
//            self.delegate?.drawFaceDetection(faces: results, onImageWithBounds: drawLayer.bounds)
//            drawLayer.setNeedsDisplay()
//        }
    }
}
