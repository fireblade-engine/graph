//
//  Node+GraphViz.swift
//  
//
//  Created by Christian Treffs on 24.03.20.
//

#if canImport(Foundation)
import struct Foundation.Data
import struct Foundation.UUID
import GraphViz
import DOT

public protocol GraphVizNodeRepresentable {
    func graphVizNode() -> GraphViz.Node
}

extension Node where Content: GraphVizNodeRepresentable {
    public final func renderGraph(as format: Format) -> Data? {
        var graph = Graph(directed: true, strict: true)
        
        descend { (node) in
            node.renderNode(in: &graph)
        }
        
        do {
            return try graph.render(using: .dot, to: format)
        } catch {
            return nil
        }
    }
    
    public final func renderNode(in graph: inout Graph) {
        let currentNode = content.graphVizNode()
        graph.append(currentNode)
        children.forEach {
            let childNode = $0.content.graphVizNode()
            graph.append(childNode)
            graph.append(Edge(from: currentNode, to: childNode))
        }
    }
}

extension String: GraphVizNodeRepresentable {
    public func graphVizNode() -> GraphViz.Node { return .init(self) }
}
extension Int: GraphVizNodeRepresentable {
    public func graphVizNode() -> GraphViz.Node { return .init("\(self)") }
}
extension UInt: GraphVizNodeRepresentable {
    public func graphVizNode() -> GraphViz.Node { return .init("\(self)") }
}
extension UInt8: GraphVizNodeRepresentable {
    public func graphVizNode() -> GraphViz.Node { return .init("\(self)") }
}

extension UUID: GraphVizNodeRepresentable {
    public func graphVizNode() -> GraphViz.Node { return .init(self.uuidString) }
}

#endif

#if canImport(AppKit)
import class AppKit.NSImage
public typealias Image = NSImage
extension Node where Content: GraphVizNodeRepresentable {
    public final func renderGraphAsImage() -> Image? {
        guard let data = renderGraph(as: .png) else {
            return nil
        }
        
        return Image(data: data)
    }
}

#elseif canImport(UIKit)
import class UIKit.UIImage
public typealias Image = UIImage
extension Node where Content: GraphVizNodeRepresentable {
    public final func renderGraphAsImage() -> Image? {
        guard let data = renderGraph(as: .png) else {
            return nil
        }
        
        return Image(data: data)
    }
}
#endif
