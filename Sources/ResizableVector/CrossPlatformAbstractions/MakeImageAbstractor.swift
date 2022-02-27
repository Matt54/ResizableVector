//  MakeImageAbstractor.swift
//  Created by Matt Pfeiffer on 2/27/22.

import SwiftUI

class MakeImageAbstractor {
    static func makeResizedImage(name: String, bundle: Bundle? = nil, frame: CGSize, keepAspectRatio: Bool) -> Image? {
        guard let platformImage = PlatformImage.makePlatformImage(named: name, in: bundle) else { return nil }
        let resizeTo = keepAspectRatio ? MakeImageAbstractor.getSizeWithAspectRatio(image: platformImage, newSize: frame) : frame
        return Image(platformImage: platformImage.resized(to: resizeTo))
    }

    fileprivate static func getSizeWithAspectRatio(image: PlatformImage, newSize: CGSize) -> CGSize {
        var scaledSize = newSize
        var scaleFactor: CGFloat
        if image.size.width > image.size.height {
            scaleFactor = image.size.width / image.size.height
            scaledSize.width = newSize.height
            scaledSize.height = newSize.height / scaleFactor
        } else {
            scaleFactor = image.size.height / image.size.width
            scaledSize.height = newSize.width
            scaledSize.width = newSize.width / scaleFactor
        }
        return scaledSize
    }
}
