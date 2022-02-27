//  PlatformImage.swift
//  Created by Matt Pfeiffer on 2/27/22.

import SwiftUI

extension PlatformImage {
    func resized(to size: CGSize) -> PlatformImage {
        return GraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

// MARK: Cocoa

#if os(OSX)
import Cocoa

typealias PlatformImage = NSImage

extension PlatformImage {
    static func makePlatformImage(named: String, in bundle: Bundle?) -> PlatformImage? {
        if let bundle = bundle {
            return bundle.image(forResource: named)
        } else {
            return PlatformImage(named: named)
        }
    }
}

extension Image {
    init(platformImage: PlatformImage) {
        self.init(nsImage: platformImage)
    }
}

// MARK: UIKit

#else
import UIKit

typealias PlatformImage = UIImage

extension PlatformImage {
    static func makePlatformImage(named: String, in bundle: Bundle?) -> PlatformImage? {
        return PlatformImage(named: named, in: bundle, with: nil)
    }
}

extension Image {
    init(platformImage: PlatformImage) {
        self.init(uiImage: platformImage)
    }
}
#endif
