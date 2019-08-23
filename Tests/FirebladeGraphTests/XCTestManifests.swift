#if !canImport(ObjectiveC)
import XCTest

extension NodeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NodeTests = [
        ("testBasics", testBasics),
        ("testDescriptionDescending", testDescriptionDescending),
        ("testEquality", testEquality),
        ("testRemoveAllChildren", testRemoveAllChildren),
        ("testRemoveChildAtIndex", testRemoveChildAtIndex),
        ("testRemoveMissingChild", testRemoveMissingChild),
    ]
}

extension TraversalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TraversalTests = [
        ("testAscendLinearGraph", testAscendLinearGraph),
        ("testAscendReduceLinearGraph", testAscendReduceLinearGraph),
        ("testDescendLinearGraph", testDescendLinearGraph),
        ("testDescendReduceLinearGraph", testDescendReduceLinearGraph),
        ("testDescendSpreadingGraph", testDescendSpreadingGraph),
    ]
}

extension UpdateTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__UpdateTests = [
        ("testUpdateChildren", testUpdateChildren),
        ("testUpdateSelf", testUpdateSelf),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NodeTests.__allTests__NodeTests),
        testCase(TraversalTests.__allTests__TraversalTests),
        testCase(UpdateTests.__allTests__UpdateTests),
    ]
}
#endif
