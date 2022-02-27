//  ResizableVector.swift
//  Created by Matt Pfeiffer on 2/27/22.

import SwiftUI

public struct ResizableVector: View {
    var name: String
    var bundle: Bundle?
    var keepAspectRatio: Bool = false
    
    private var aspectRatio: CGFloat?

    public init(_ name: String) {
        self.name = name
    }

    public init(_ name: String, bundle: Bundle?) {
        self.name = name
        self.bundle = bundle
    }

    public init(_ name: String, keepAspectRatio: Bool) {
        self.name = name
        self.keepAspectRatio = keepAspectRatio
        aspectRatio = keepAspectRatio ? getAspectRatio(name, bundle: bundle) : nil
    }

    public init(_ name: String, bundle: Bundle?, keepAspectRatio: Bool) {
        self.name = name
        self.bundle = bundle
        self.keepAspectRatio = keepAspectRatio
        aspectRatio = keepAspectRatio ? getAspectRatio(name, bundle: bundle) : nil
    }
    
    private func getAspectRatio(_ name: String, bundle: Bundle?) -> CGFloat? {
        guard let image = PlatformImage.makePlatformImage(named: name, in: nil) else { return nil }
        let width = image.size.width
        let height = image.size.height
        return width/height
    }

    public var body: some View {
        Group {
            if keepAspectRatio {
                Color.clear
                    .aspectRatio(aspectRatio, contentMode: .fit)
            } else {
                Color.clear
            }
        }
        .overlay (
            GeometryReader {
                geometry in
                MakeImageAbstractor.makeResizedImage(name: name,
                                                     bundle: bundle,
                                                     frame: geometry.size,
                                                     keepAspectRatio: keepAspectRatio)
            }
        )
    }
}

struct ResizableVector_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack{
                Text("ResizeableVector()")
                ResizableVector("example", bundle: Bundle.module, keepAspectRatio: true)
                    .frame(width: 200)
                    .background(Color.green)
            }
            
            VStack{
                Text("Image()")
                Image("example", bundle: Bundle.module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .background(Color.green)
            }
        }
        .previewLayout(.fixed(width: 850, height: 400))
    }
}
