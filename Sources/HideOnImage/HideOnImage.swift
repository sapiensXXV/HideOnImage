#if os(iOS)
    import UIKit
#endif

@main
public struct HideOnImage {
    public private(set) var text = "Hello, World!"
    
    public static func main() {
        print("모자이크 시작")
    }
}
