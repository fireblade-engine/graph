//
//  GraphvizRepresentable.swift
//
//
//  Created by Christian Treffs on 24.03.20.
//

import struct Foundation.Data
import struct Foundation.UUID
import GraphViz

public protocol GraphVizNodeRepresentable {
    func graphVizNodeDescription() -> String
}

extension GraphVizNodeRepresentable {
    internal func graphVizNode() -> GraphViz.Node {
        .init(graphVizNodeDescription())
    }
}

extension String: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() -> String { self }
}
extension Int: GraphVizNodeRepresentable {
    public func graphVizNodeDescription() -> String { "\(self)" }
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
    func renderGraph(as format: Format, completion: (@escaping (Result<Data, Swift.Error>) -> Void))
}

extension Image {
    public enum Error: Swift.Error {
        case failedToCreateImage(_ from: Data)
    }
}

#if canImport(AppKit)
import class AppKit.NSImage
public typealias Image = NSImage
extension GraphVizRenderable {
    public func renderGraphAsImage(completion: @escaping (Result<Image, Swift.Error>) -> Void) {
        renderGraph(as: .png) { result in
            switch result {
            case .success(let data):
                if let image = Image(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(Image.Error.failedToCreateImage(data)))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

#elseif canImport(UIKit)
import class UIKit.UIImage
public typealias Image = UIImage
extension GraphVizRenderable {
    public func renderGraphAsImage(completion: @escaping (Result<Image, Swift.Error>) -> Void) {
        renderGraph(as: .png) { result in
            switch result {
            case .success(let data):
                if let image = Image(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(Image.Error.failedToCreateImage(data)))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
#endif
