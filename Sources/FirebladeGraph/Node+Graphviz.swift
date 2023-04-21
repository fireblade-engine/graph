//
//  Node+GraphViz.swift
//
//
//  Created by Christian Treffs on 24.03.20.
//

import GraphViz
import struct Foundation.Data

extension Node: GraphVizRenderable where Content: GraphVizNodeRepresentable {
    public final func renderGraph(as format: Format, completion: @escaping (Result<Data, Swift.Error>) -> Void) {
        var graph = Graph(directed: true, strict: true)

        descend { node in
            node.renderNode(in: &graph)
        }

        graph.render(using: .dot, to: format, completion: completion)
    }

    final func renderNode(in graph: inout GraphViz.Graph) {
        let currentNode = content.graphVizNode()
        graph.append(currentNode)
        children.forEach {
            let childNode = $0.content.graphVizNode()
            graph.append(childNode)
            graph.append(Edge(from: currentNode, to: childNode))
        }
    }
}
