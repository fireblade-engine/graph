//
//  NodeTests.swift
//
//
//  Created by Christian Treffs on 22.08.19.
//

import FirebladeGraph
import XCTest

final class NodeTests: XCTestCase {
    func testBasics() {
        let rootNode = Node()

        let c01 = Node()
        let c02 = Node()

        XCTAssertTrue(rootNode.children.isEmpty)
        XCTAssertNil(rootNode.parent)

        XCTAssertEqual(rootNode.children.count, 0)

        rootNode.addChild(c01)

        XCTAssertTrue(c01.parent === rootNode)
        XCTAssertEqual(c01.parent, rootNode)
        XCTAssertEqual(c01.children.count, 0)
        XCTAssertEqual(rootNode.children.count, 1)

        rootNode.addChild(c02)
        XCTAssertTrue(c02.parent === rootNode)
        XCTAssertEqual(c02.parent, rootNode)
        XCTAssertEqual(c02.children.count, 0)
        XCTAssertEqual(rootNode.children.count, 2)

        c01.removeFromParent()

        XCTAssertEqual(rootNode.children.count, 1)

        rootNode.removeChild(c02)

        XCTAssertNil(rootNode.parent)
        XCTAssertEqual(rootNode.children.count, 0)
        XCTAssertNil(c01.parent)
        XCTAssertNil(c02.parent)
    }

    func testEquality() {
        let n1 = Node()
        let n2 = Node()

        XCTAssertEqual(n1, n1)
        XCTAssertEqual(n2, n2)
        XCTAssertNotEqual(n1, n2)

        let sn1 = Node()
        let sn2 = Node()

        XCTAssertEqual(sn1, sn1)
        XCTAssertEqual(sn2, sn2)
        XCTAssertNotEqual(sn1, sn2)
    }

    func testRemoveChildAtIndex() {
        let node = Node()

        let c01 = Node()
        let c02 = Node()

        node.addChild(c01)
        node.addChild(c02)

        XCTAssertEqual(node.children.count, 2)
        XCTAssertEqual(node[1], c02)

        node.removeChild(at: 1)

        XCTAssertEqual(node.children.count, 1)
        XCTAssertEqual(node.children.first, c01)
    }

    func testRemoveAllChildren() {
        let node = Node()

        let c01 = Node()
        let c02 = Node()

        node.addChild(c01)
        node.addChild(c02)

        XCTAssertEqual(node.children.count, 2)

        node.removeAllChildren()

        XCTAssertEqual(node.children.count, 0)
    }

    func testRemoveMissingChild() {
        let a = Node()
        let b = Node()

        a.addChild(b)
        XCTAssertEqual(a.children.count, 1)

        XCTAssertNil(a.removeChild(a))
        XCTAssertEqual(a.children.count, 1)

        XCTAssertNil(a.removeChild(a))
        XCTAssertNil(b.removeChild(b))

        XCTAssertEqual(a.children.count, 1)
        XCTAssertEqual(b.children.count, 0)
    }

    func testDescriptionDescending() {
        let rootNode = Node()

        let c1 = Node()
        c1.addChild(Node())
        rootNode.addChild(Node())
        rootNode.addChild(c1)
        rootNode.addChild(Node())

        XCTAssertFalse(rootNode.description.isEmpty)
        XCTAssertFalse(rootNode.debugDescription.isEmpty)
        XCTAssertNotEqual(rootNode.description, rootNode.debugDescription)
        XCTAssertFalse(rootNode.debugDescriptionDescending.isEmpty)
        XCTAssertFalse(rootNode.descriptionDescending.isEmpty)
        XCTAssertNotEqual(rootNode.debugDescriptionDescending, rootNode.descriptionDescending)
    }
}
