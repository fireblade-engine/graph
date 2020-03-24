//
//  GraphvizRepresentable.swift
//
//
//  Created by Christian Treffs on 24.03.20.
//

import struct Foundation.Data
import struct Foundation.UUID
import DOT
import GraphViz

public protocol GraphVizNodeRepresentable {
    func graphVizNodeDescription() -> String
}

extension GraphVizNodeRepresentable {
    internal func graphVizNode() -> GraphViz.Node {
        return .init(graphVizNodeDescription())
    }
}

extension String: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() -> String { self }
}
extension Int: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() ->String { "\(self)" }
}
extension UInt: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() -> String { "\(self)" }
}
extension UInt8: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() -> String { "\(self)" }
}

extension UUID: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() -> String { uuidString }
}


public protocol GraphVizRenderable {
    func renderGraph(as format: Format) -> Data?
}

#if canImport(AppKit)
import class AppKit.NSImage
public typealias Image = NSImage
extension GraphVizRenderable {
    public func renderGraphAsImage() -> Image? {
        guard let data = renderGraph(as: .png) else {
            return nil
        }

        return Image(data: data)
    }
}

#elseif canImport(UIKit)
import class UIKit.UIImage
public typealias Image = UIImage
extension GraphVizRenderable {
    public final func renderGraphAsImage() -> Image? {
        guard let data = renderGraph(as: .png) else {
            return nil
        }

        return Image(data: data)
    }
}
#endif
