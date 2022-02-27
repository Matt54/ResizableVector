/*
 adapted from work by Erica Sadun found here:
 https://gist.github.com/erica/ec3e2a4a8526e3fc3ba1fc95a0d53083#file-crossplatformdefines-swift
 */

// MARK: Cocoa

#if os(OSX)
import Cocoa

typealias GraphicsImageRenderer = MacGraphicsImageRenderer
typealias GraphicsImageRendererFormat = MacGraphicsImageRendererFormat
typealias GraphicsImageRendererContext = MacGraphicsImageRendererContext

class MacGraphicsImageRendererFormat: NSObject {
    var opaque: Bool = false
    var prefersExtendedRange: Bool = false
    var scale: CGFloat = 2.0
    var bounds: CGRect = .zero
}

class MacGraphicsImageRendererContext: NSObject {
    var format: GraphicsImageRendererFormat
    override init() {
        self.format = GraphicsImageRendererFormat()
        super.init()
    }
}

class MacGraphicsImageRenderer: NSObject {
    let format: GraphicsImageRendererFormat
    let bounds: CGRect

    init(bounds: CGRect, format: GraphicsImageRendererFormat) {
        (self.bounds, self.format) = (bounds, format)
        self.format.bounds = self.bounds
        super.init()
    }

    convenience init(size: CGSize) {
        self.init(bounds: CGRect(origin: .zero, size: size), format: GraphicsImageRendererFormat())
    }

    func image(actions: @escaping (GraphicsImageRendererContext) -> Void) -> NSImage {
        let image = NSImage(size: format.bounds.size, flipped: false) {
            (_: NSRect) -> Bool in

            let imageContext = GraphicsImageRendererContext()
            imageContext.format = self.format
            actions(imageContext)

            return true
        }
        return image
    }
}

// MARK: UIKit

#else
import UIKit

typealias GraphicsImageRenderer = UIGraphicsImageRenderer
#endif
