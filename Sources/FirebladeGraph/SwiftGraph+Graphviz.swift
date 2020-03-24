//
//  SwiftGraph+Graphviz.swift
//
//
//  Created by Christian Treffs on 24.03.20.
//

import DOT
import Foundation
import GraphViz
@_exported import SwiftGraph

extension UniqueElementsGraph: GraphVizRenderable where V: GraphVizNodeRepresentable {
    public final func renderGraph(as format: Format) -> Data? {
        drawGraphUnweigted(self, as: format)
    }
}

extension UnweightedGraph: GraphVizRenderable where V: GraphVizNodeRepresentable {
    public final func renderGraph(as format: Format) -> Data? {
        drawGraphUnweigted(self, as: format)
    }
}

extension WeightedGraph: GraphVizRenderable where V: GraphVizNodeRepresentable, W: Numeric {
    public final func renderGraph(as format: Format) -> Data? {
        drawGraphWeigted(self, as: format)
    }
}


private func drawGraphUnweigted<G>(_ graph: G, as format: Format) -> Data? where G: SwiftGraph.Graph, G.V: GraphVizNodeRepresentable {
    let directed = graph.isDAG
    var graphvizGraph = Graph(directed: directed, strict: true)

    graph.vertices.forEach {
        graphvizGraph.append($0.graphVizNode())
    }

    graph.edgeList().forEach { edge in
        let direction: GraphViz.Edge.Direction = edge.directed ? .forward : .none
        let from = graph.vertexAtIndex(edge.u)
        let to = graph.vertexAtIndex(edge.v)
        
        let gEdge = GraphViz.Edge(from: from.graphVizNode(), to: to.graphVizNode(), direction: direction)
        graphvizGraph.append(gEdge)
    }

    let layout: LayoutAlgorithm = directed ? .dot : .sfdp

    do {
        return try graphvizGraph.render(using: layout, to: format)
    } catch {
        return nil
    }
}


private func drawGraphWeigted<G, W>(_ graph: G, as format: Format) -> Data? where G: SwiftGraph.Graph, G.V: GraphVizNodeRepresentable, G.E == WeightedEdge<W>, W: Numeric {
    let directed = graph.isDAG
    var graphvizGraph = Graph(directed: directed, strict: true)

    graph.vertices.forEach {
        graphvizGraph.append($0.graphVizNode())
    }

    graph.edgeList().forEach { edge in
        let direction: GraphViz.Edge.Direction = edge.directed ? .forward : .none
        let from = graph.vertexAtIndex(edge.u)
        let to = graph.vertexAtIndex(edge.v)
        
        var gEdge = GraphViz.Edge(from: from.graphVizNode(), to: to.graphVizNode(), direction: direction)
        let string = String(describing: edge.weight)
        gEdge.weight = Double(string)
        gEdge.exteriorLabel = string
        graphvizGraph.append(gEdge)
    }

    let layout: LayoutAlgorithm = directed ? .dot : .sfdp

    do {
        return try graphvizGraph.render(using: layout, to: format)
    } catch {
        return nil
    }
}
