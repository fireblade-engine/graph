//
//  UpdateTests.swift
//
//
//  Created by Christian Treffs on 23.08.19.
//

import FirebladeGraph
import XCTest

// swiftlint:disable identifier_name

final class UpdateTests: XCTestCase {
    func testUpdateSelf() {
        let exp = expectation(description: "\(#function)")
        let node = TestNode(0)

        node.didUpdate = {
            XCTAssertEqual($0, node)
            exp.fulfill()
        }

        node.update()
        waitForExpectations(timeout: 1.0)
    }

    func testUpdateChildren() {
        let expRoot = expectation(description: "\(#function)-root")
        let expC1 = expectation(description: "\(#function)-c1")
        let expC2 = expectation(description: "\(#function)-c2")
        let expC3 = expectation(description: "\(#function)-c3")

        let root = TestNode(0)
        let c1 = TestNode(1)
        let c2 = TestNode(2)
        let c3 = TestNode(3)

        root.addChild(c1)
        root.addChild(c2)
        c2.addChild(c3)

        root.didUpdate = {
            XCTAssertEqual($0, root)
            expRoot.fulfill()
        }

        c1.didUpdate = {
            XCTAssertEqual($0, c1)
            expC1.fulfill()
        }

        c2.didUpdate = {
            XCTAssertEqual($0, c2)
            expC2.fulfill()
        }

        c3.didUpdate = {
            XCTAssertEqual($0, c3)
            expC3.fulfill()
        }

        root.update()

        wait(for: [expRoot, expC1, expC2, expC3], timeout: 1.0, enforceOrder: true)
    }
}

typealias UpdateCallback = (TestNode) -> Void

class TestNode: Node<UInt8> {
    var didUpdate: UpdateCallback?

    override func updateFromParent() {
        super.updateFromParent()
        didUpdate?(self)
    }
}
