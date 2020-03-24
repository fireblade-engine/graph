//
//  TraversalTests.swift
//
//
//  Created by Christian Treffs on 22.08.19.
//

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import FirebladeGraph
import struct Foundation.UUID
import SnapshotTesting

// swiftlint:disable identifier_name

final class TraversalTests: XCTestCase {
    typealias StringNode = Node<String>

    func testDescendLinearGraph() {
        let a = StringNode("a")
        let b = StringNode("b")
        let c = StringNode("c")
        let d = StringNode("d")
        let e = StringNode("e")
        let f = StringNode("f")
        let g = StringNode("g")
        let h = StringNode("h")
        let i = StringNode("i")
        let j = StringNode("j")

        a.addChild(b)
        b.addChild(c)
        c.addChild(d)
        d.addChild(e)
        e.addChild(f)
        f.addChild(g)
        g.addChild(h)
        h.addChild(i)
        i.addChild(j)

        var result: [String] = []

        a.descend {
            result.append($0.content)
        }

        let expected = [a, b, c, d, e, f, g, h, i, j].map { $0.content }
        XCTAssertEqual(result, expected)

        assertSnapshot(matching: a.renderGraphAsImage()!, as: .image)
    }

    func testDescendSpreadingGraph() {
        let a = Node<Int>(0)
        let b = Node<Int>(1)
        let c = Node<Int>(2)
        let d = Node<Int>(3)
        let e = Node<Int>(4)
        let f = Node<Int>(5)
        let g = Node<Int>(6)
        let h = Node<Int>(7)
        let i = Node<Int>(8)
        let j = Node<Int>(9)

        a.addChild(b)

        b.addChild(c)
        b.addChild(d)

        c.addChild(e)
        c.addChild(f)
        c.addChild(g)

        d.addChild(h)
        d.addChild(i)
        d.addChild(j)

        var result: [Int] = []

        a.descend {
            result.append($0.content)
        }
        let expected = [a, b, c, e, f, g, d, h, i, j].map { $0.content }
        XCTAssertEqual(result, expected)

        assertSnapshot(matching: a.renderGraphAsImage()!, as: .image)
    }

    func testDescendReduceLinearGraph() {
        let a = Node<UUID>(UUID())
        let b = Node<UUID>(UUID())
        let c = Node<UUID>(UUID())
        let d = Node<UUID>(UUID())
        let e = Node<UUID>(UUID())
        let f = Node<UUID>(UUID())
        let g = Node<UUID>(UUID())
        let h = Node<UUID>(UUID())
        let i = Node<UUID>(UUID())
        let j = Node<UUID>(UUID())

        a.addChild(b)
        b.addChild(c)
        c.addChild(d)
        d.addChild(e)
        e.addChild(f)
        f.addChild(g)
        g.addChild(h)
        h.addChild(i)
        i.addChild(j)

        let result: [UUID] = a.descendReduce([UUID]()) { $0 + [$1.content] }

        let expected = [a, b, c, d, e, f, g, h, i, j].map { $0.content }
        XCTAssertEqual(result, expected)
    }

    func testAscendLinearGraph() {
        let a = Node<UUID>(.init())
        let b = Node<UUID>(.init())
        let c = Node<UUID>(.init())
        let d = Node<UUID>(.init())
        let e = Node<UUID>(.init())
        let f = Node<UUID>(.init())
        let g = Node<UUID>(.init())
        let h = Node<UUID>(.init())
        let i = Node<UUID>(.init())
        let j = Node<UUID>(.init())

        a.addChild(b)
        b.addChild(c)
        c.addChild(d)
        d.addChild(e)
        e.addChild(f)
        f.addChild(g)
        g.addChild(h)
        h.addChild(i)
        i.addChild(j)

        var result: [UUID] = []

        j.ascend {
            result.append($0.content)
        }

        let expected = [a, b, c, d, e, f, g, h, i, j].reversed().map { $0.content }
        XCTAssertEqual(result, expected)
    }

    func testAscendReduceLinearGraph() {
        let a = Node<UUID>(.init())
        let b = Node<UUID>(.init())
        let c = Node<UUID>(.init())
        let d = Node<UUID>(.init())
        let e = Node<UUID>(.init())
        let f = Node<UUID>(.init())
        let g = Node<UUID>(.init())
        let h = Node<UUID>(.init())
        let i = Node<UUID>(.init())
        let j = Node<UUID>(.init())

        a.addChild(b)
        b.addChild(c)
        c.addChild(d)
        d.addChild(e)
        e.addChild(f)
        f.addChild(g)
        g.addChild(h)
        h.addChild(i)
        i.addChild(j)

        let result: [UUID] = j.ascendReduce([UUID]()) { $0 + [$1.content] }

        let expected = [a, b, c, d, e, f, g, h, i, j].reversed().map { $0.content }
        XCTAssertEqual(result, expected)
    }
}
