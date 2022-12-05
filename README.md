# HideOnImage
<p align="center">
<img width="250" src="https://user-images.githubusercontent.com/76734067/205505718-59d7df70-2eb5-4c3a-b84e-957a79118b1c.gif">
</p>

`HideOnImage`는 얼굴인식 자동모자이크 라이브러리입니다. 자동으로 이미지의 얼굴을 인식하고 모자이크 처리해줍니다.

## 설치
Swift Package Manager(SPM)에 다음 Package URL로 사용할 수 있습니다.
```
https://github.com/January1st-98/HideOnImage.git
```

# 사용법

- Mosaic 인스턴스를 생성한다.
- Mosaic 인스턴스의 `delegate`를 현재 처리할 뷰 컨트롤러로 지정합니다.
- `UIImage`이미지 데이터를 `convert(with:type:)`메서드의 파라미터로 넘겨 모자이크 이미지로 변환을 시작합니다.
- `MosaicDelegate` 프로토콜의 Delegate 메서드를 구현한다.
- `mosaicImageProcessDidFinish(result:)` delegate 메서드의 파라미터로 주어지는 결과 이미지를 사용한다.
```swift
let mosaic = Mosaic()
mosaic.delegate = self

let image = UIImage(named: "my-image")
mosaic.convert(with: image)

...

extension class_name: MosaicDelegate {

    func mosaicImageProcessDidFinish(with result: UIImage) {
        self.imageView.image = result
    }
}
```

## 얼굴탐지 유형선택
얼굴을 탐지하는데는 다음 두가지 유형 중 하나를 선택할 수 있습니다.
- Vision Framework
- CIDetector

`convert(with:type:)`메서드를 호출할 때 어떤 유형으로 얼굴을 탐지할 지 선택할 수 있습니다. 타입은 `ConvertType`열거형으로 구분됩니다.

### Vision Framework를 사용하기
기본값은 Vision Framework를 사용하는 것입니다. Vision Framework를 사용하려면 다음과 같이 사용하십시요.
```swift
let image = UIImage(named: "my-image")
mosaic.convert(with: image)
```
또는
```swift
let image = UIImage(named: "my-image")
mosaic.convert(with: image, type: .vision)
```

### CIDetector
`CIDetector`를 사용하려면 다음과 같이 사용하십시요
```swift
let image = UIImage(named: "my-image")
mosaic.convert(with: image, type: .ciDetector)
```

### 선택
- CIDetector의 정확도는 `CIDetectorAccuracyLow`로, 낮게 설정되어 있습니다. 리소스 사용이 적고 빠르게 얼굴을 모자이크하고 싶다면 이 옵션을 선택하세요.
- Vision Framework는 정확도가 높지만 `CIDetector`에 비해 오버헤드가 많이 듦니다. 정확도를 중요하게 여긴다면 이 옵션을 선택하세요 

## ⚠️ 주의

시뮬레이터에서 실행하는 경우 다음 코드를 추가해야합니다.
```swift
#if targetEnvironment(simulator)
    mosaic.faceDetectionRequest.usesCPUOnly = true
#endif
```

---

HideOnImage is a face detection automatic mosaic library. It automatically recognizes and mosaic the face of the image.

# Installation
Available in Swift Package Manager (SPM) as the following package URL
```
https://github.com/January1st-98/HideOnImage.git
```

## How to use it

- Create a Mosaic instance.
- Specifies the `delegate` of the Mosaic instance as the view controller to be processed at this time.
- Transfer the `UIImage` image data to the parameter of the `convert(with:)` method and start conversion to a mosaic image.
- Implement the `MosaicDelegate` protocol`s Delay method.
- It uses the resulting image given as a parameter of the `mosaicImageProcessDidFinish(result:)` delegate method.

```swift
let mosaic = Mosaic()
mosaic.delegate = self

let image = UIImage(named: "my-image")
mosaic.convert(with: image)
...

extension class_name: MosaicDelegate {

    func mosaicImageProcessDidFinish(with result: UIImage) {
        self.imageView.image = result
    }
}
```

## Select Face Detection Type
You can choose one of two types of face detection:
- Vision Framework
- CIDetector

When calling the `convert(with:type:)` method, you can choose which type to detect the face. Types are categorized as 'ConvertType' enumeration.

### Using the Vision Framework
The default is to use the Vision Framework. To use the Vision Framework:
```swift
let image = UIImage(named: "my-image")
mosaic.convert(with: image)
```
or
```swift
let image = UIImage(named: "my-image")
mosaic.convert(with: image, type: .vision)
```

### Using the CIDetector
To use `CIDetector`:
```swift
let image = UIImage(named: "my-image")
mosaic.convert(with: image, type: .ciDetector)
```

### Select
- The accuracy of the CIDetector is set to `CIDetectorAccuracyLow`. Select this option if you are using less resources and want to mosaic image's faces quickly.
- The Vision Framework is more accurate, but it takes more overhead and resources than the `CIDetector`. Choose this option if you want your face detection to be accurate

## ⚠️ CAUTION
When running on a simulator, you must add the following code:
```swift
#if targetEnvironment(simulator)
mosaic.faceDetectionRequest.usesCPUOnly = true
#endif
```
