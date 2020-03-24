//
//  TestVisualization.swift
//
//
//  Created by Christian Treffs on 24.03.20.
//

import FirebladeGraph
import SnapshotTesting
import XCTest

// swiftlint:disable identifier_name

final class TestVisualization: XCTestCase {
    struct Person: Codable, Equatable, GraphVizNodeRepresentable {
        let firstName: String
        let lastName: String

        func graphVizNodeDescription() -> String {
            "\(firstName) \(lastName)"
        }
    }
    func testCicularUndirectedVisualization() {
        let john = Person(firstName: "John", lastName: "Doe")
        let jane = Person(firstName: "Jane", lastName: "Doe")
        let max = Person(firstName: "Max", lastName: "Mustermann")

        let friends = UnweightedGraph<Person>(vertices: [john, jane, max])
        friends.addEdge(from: john, to: jane)
        friends.addEdge(from: john, to: max)
        friends.addEdge(from: max, to: jane)

        #if !os(Linux)
        guard let image = friends.renderGraphAsImage() else {
            XCTFail("No rendering done")
            return
        }
        assertSnapshot(matching: image, as: .image)
        #endif
    }

    func testCicularDirectedVisualization() {
        let john = Person(firstName: "John", lastName: "Doe")
        let jane = Person(firstName: "Jane", lastName: "Doe")
        let max = Person(firstName: "Max", lastName: "Mustermann")

        let friends = UnweightedGraph<Person>(vertices: [john, jane, max])
        friends.addEdge(from: john, to: jane, directed: true)
        friends.addEdge(from: john, to: max, directed: true)
        friends.addEdge(from: max, to: jane, directed: true)

        #if !os(Linux)
        guard let image = friends.renderGraphAsImage() else {
            XCTFail("No rendering done")
            return
        }
        assertSnapshot(matching: image, as: .image)
        #endif
    }

    func testCityGraphVisualization() {
        let cityGraph: WeightedGraph<String, Int> = WeightedGraph<String, Int>(vertices: ["Seattle", "San Francisco", "Los Angeles", "Denver", "Kansas City", "Chicago", "Boston", "New York", "Atlanta", "Miami", "Dallas", "Houston"])

        cityGraph.addEdge(from: "Seattle", to: "Chicago", weight: 2097)
        cityGraph.addEdge(from: "Seattle", to: "Chicago", weight: 2097)
        cityGraph.addEdge(from: "Seattle", to: "Denver", weight: 1331)
        cityGraph.addEdge(from: "Seattle", to: "San Francisco", weight: 807)
        cityGraph.addEdge(from: "San Francisco", to: "Denver", weight: 1267)
        cityGraph.addEdge(from: "San Francisco", to: "Los Angeles", weight: 381)
        cityGraph.addEdge(from: "Los Angeles", to: "Denver", weight: 1015)
        cityGraph.addEdge(from: "Los Angeles", to: "Kansas City", weight: 1663)
        cityGraph.addEdge(from: "Los Angeles", to: "Dallas", weight: 1435)
        cityGraph.addEdge(from: "Denver", to: "Chicago", weight: 1003)
        cityGraph.addEdge(from: "Denver", to: "Kansas City", weight: 599)
        cityGraph.addEdge(from: "Kansas City", to: "Chicago", weight: 533)
        cityGraph.addEdge(from: "Kansas City", to: "New York", weight: 1260)
        cityGraph.addEdge(from: "Kansas City", to: "Atlanta", weight: 864)
        cityGraph.addEdge(from: "Kansas City", to: "Dallas", weight: 496)
        cityGraph.addEdge(from: "Chicago", to: "Boston", weight: 983)
        cityGraph.addEdge(from: "Chicago", to: "New York", weight: 787)
        cityGraph.addEdge(from: "Boston", to: "New York", weight: 214)
        cityGraph.addEdge(from: "Atlanta", to: "New York", weight: 888)
        cityGraph.addEdge(from: "Atlanta", to: "Dallas", weight: 781)
        cityGraph.addEdge(from: "Atlanta", to: "Houston", weight: 810)
        cityGraph.addEdge(from: "Atlanta", to: "Miami", weight: 661)
        cityGraph.addEdge(from: "Houston", to: "Miami", weight: 1187)
        cityGraph.addEdge(from: "Houston", to: "Dallas", weight: 239)

        #if !os(Linux)
        guard let image = cityGraph.renderGraphAsImage() else {
            XCTFail("No rendering done")
            return
        }
        assertSnapshot(matching: image, as: .image)
        #endif
    }
}
