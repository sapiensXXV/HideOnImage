# HideOnImage
<p align="center">
<img width="250" src="https://user-images.githubusercontent.com/76734067/205505718-59d7df70-2eb5-4c3a-b84e-957a79118b1c.gif">
</p>

`HideOnImage`는 얼굴인식 자동모자이크 라이브러리입니다. 자동으로 이미지의 얼굴을 인식하고 모자이크 처리해줍니다.

[한국어](#설치) [ENGLISH](#installation)

## 설치
Swift Package Manager(SPM)에 다음 Package URL로 사용할 수 있습니다.
```
https://github.com/mynameisjaehoon/HideOnImage.git
```

## 사용법

- Mosaic 인스턴스를 생성한다.
- Mosaic 인스턴스의 `delegate`를 현재 처리할 뷰 컨트롤러로 지정합니다.
- `UIImage`이미지 데이터를 `convert(with:)`메서드의 파라미터로 넘겨 모자이크 이미지로 변환을 시작합니다.
- `MosaicDelegate` 프로토콜의 Delegate 메서드를 구현한다.
- `mosaicImageProcessDidFinish(result:)` delegate 메서드의 파라미터로 주어지는 결과 이미지를 사용한다.
```swift
let mosaic = Mosaic()
mosaic.delegate = self

let image = UIImage(named: "my-image")
mosaic.convert(uiImage: image)

...

extension class_name: MosaicDelegate {

    func mosaicImageProcessDidFinish(with result: UIImage) {
        self.imageView.image = result
    }
}
```
## 모자이크 설정정보 수정하기
Mosaic객체 내부의 configuration프로퍼티를 사용하여 모자이크의 옵션을 선택할 수 있습니다. 옵션으로는 다음을 선택할 수 있습니다.
- 얼굴탐지 유형
    - Vision Framework
    - CIDetector
- 모자이크 radius

### 얼굴탐지 유형선택
얼굴을 탐지하는데는 **`Vision Framework`** 와 **`CIDetector`** 두가지 유형 중 하나를 선택할 수 있습니다.

- Vision Framework를 사용하기
    기본값은 Vision Framework를 사용하는 것입니다. Vision Framework를 사용하려면 다음과 같이 사용하십시요.
    ```swift
    let image = UIImage(named: "my-image")
    mosaic.convert(uiImage: image)
    ```
    또는
    ```swift
    let image = UIImage(named: "my-image")
    let configuration = MosaicConfiguration()
    configuration.aiType = .vision
    mosaic.configuration = configuration
    mosaic.convert(uiImage: image)
    ```

- CIDetector
    `CIDetector`를 사용하려면 다음과 같이 사용하십시요
    ```swift
    let image = UIImage(named: "my-image")
    let configuration = MosaicConfiguration()
    configuration.aiType = .ciDetector
    mosaic.configuration = configuration
    mosaic.convert(uiImage: image)
    ``` 

### 모자이크 radius설정
모자이크 정도인 radius를 설정할 수 있습니다. 기본 radius값은 `15`입니다.<br>
아래의 코드는 `CIDetector`로 탐지하면서 radius를 `30`으로 설정하는 경우입니다.

```swift
let image = UIImage(named: "my-image")
let configuration = MosaicConfiguration()
configuration.aiType = .ciDetector
configuration.radius = 30
mosaic.convert(uiImage: image)
```

## 이미지 타입 설정
다음 타입의 이미지를 전달해 모자이크를 처리할 수 있습니다.
- **`UIImage`** 
- **`CGImage`**
- **`CIImage`**

세가지 타입의 이미지를 받는 convert메서드가 정의되어있습니다.
```swift
func convert(uiImage: UIImage?)
func convert(cgImage: CGImage?)
func convert(ciImage: CIImage?)
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

## Installation
Available in Swift Package Manager (SPM) as the following package URL
```
https://github.com/mynameisjaehoon/HideOnImage.git
```

## How to use it

- Create a Mosaic instance.
- Specifies the `delegate` of the Mosaic instance as the view controller to be currently processed.
- Pass the `UIImage` image data to the parameters of the `convert(with:)` method to begin conversion into a mosaic image.
- Implement the `MosaicDelegate` protocol's Delegate method.
- We use the resulting image given as a parameter of the `mosaicImageProcessDidFinish` delegate method.
```swift
let mosaic = Mosaic()
mosaic.delegate = self // Important

let image = UIImage(named: "my-image")
mosaic.convert(uiImage: image)

...

extension class_name: MosaicDelegate {

    func mosaicImageProcessDidFinish(with result: UIImage) {
        self.imageView.image = result
    }
}
```

## How to Modify **`Mosaic`** configurations
You can use the configuration properties inside the Mosaic object to select options for the mosaic. Options include:
- Face detection type
    - Vision Framework
    - CIDetector
- Mosaic radius

### Select face detection type
You can choose between **`Vision Framework`** and **`CIDetector`** to detect faces.

- **Vision Framework**
    The default is to use the Vision Framework. To use the Vision Framework:
    ```swift
    let image = UIImage(named: "my-image")
    mosaic.convert(uiImage: image)
    ```
    Or
    ```swift
    let image = UIImage(named: "my-image")
    let configuration = MosaicConfiguration()
    configuration.aiType = .vision
    mosaic.configuration = configuration
    mosaic.convert(uiImage: image)
    ```

- **CIDetector**
    To use `CIDetector`, use as follows
    ```swift
    let image = UIImage(named: "my-image")
    let configuration = MosaicConfiguration()
    configuration.aiType = .ciDetector
    mosaic.configuration = configuration
    mosaic.convert(uiImage: image)
    ``` 

### Mosaic radius setting
You can set the radius, which is the degree of mosaic. The default radius value is `15`.<br>
The code below is for detecting `CIDetector` and setting radius to `30`.
```swift
let image = UIImage(named: "my-image")
let configuration = MosaicConfiguration()
configuration.aiType = .ciDetector
configuration.radius = 30
mosaic.convert(uiImage: image)
```

## Set Image Type
The following types of images can be passed to process mosaic:
- **`UIImage`** 
- **`CGImage`**
- **`CIImage`**

A convert method that receives three types of images is defined.
```swift
func convert(uiImage: UIImage?)
func convert(cgImage: CGImage?)
func convert(ciImage: CIImage?)
```

### Select
- The accuracy of the `CIDetector` is set to `CIDetectorAccuracyLow`. Select this option if you are using less resources and want to mosaic image's' faces quickly.
- The Vision Framework is more accurate, but it takes more overhead and resources than the `CIDetector`. Choose this option if you want your face detection to be accurate

## ⚠️ CAUTION
When running on a simulator, you must add the following code:
```swift
#if targetEnvironment(simulator)
mosaic.faceDetectionRequest.usesCPUOnly = true
#endif
```
