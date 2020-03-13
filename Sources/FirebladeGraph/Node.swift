//
//  Node.swift
//  FirebladeGraph
//
//  Created by Christian Treffs on 16.05.18.
//

/// **Node<Content>**
///
/// A node in a directed acyclic graph (DAG).
open class Node<Content> {
    public typealias CurrentNode = Node<Content>
    public typealias ChildNode = Node<Content>
    public typealias ParentNode = Node<Content>

    /// The node's content.
    public final let content: Content

    /// The node's parent node.
    /// Nil if this node is the root node.
    public internal(set) final weak var parent: ParentNode?

    /// All children of this node in order of addition.
    public internal(set) final var children: [ChildNode]

    public init(_ content: Content) {
        self.content = content
        self.children = []
    }

    deinit {
        removeAllChildren()
        removeFromParent()
    }

    /// Adds the given (precreated) node as a child to this node.
    /// If the given node is attached to another node it must be detached first.
    /// The given node may not be this node (DAG).
    ///
    /// - Parameter child: The node which is to become a child node of this node.
    /// - Returns: The child node.
    @discardableResult
    public final func addChild(_ child: ChildNode) -> Self {
        precondition(child.parent == nil, "can not add a child with an assigned parent")
        precondition(child !== self, "can not add self as child of itself")

        children.append(child)
        child.parent = self
        return self
    }

    /// Get child node by index.
    ///
    /// - Parameter childIndex: The child index. Must exist.
    public final subscript(_ childAtIndex: Int) -> ChildNode {
        children[childAtIndex]
    }

    /// Remove this node (self) as child from it's parent (self.parent).
    public final func removeFromParent() {
        parent?.removeChild(self)
    }

    /// Remove child node at index from this node.
    /// - Parameter index: Index of child node. Must exist.
    @discardableResult
    public final func removeChild(at index: Int) -> ChildNode? {
        guard children.count > index else {
            return nil
        }

        children.swapAt(index, children.endIndex - 1)
        guard let lastChild = children.popLast() else {
            return nil
        }
        lastChild.parent = nil
        return lastChild
    }

    /// Remove a given child node from this node.
    /// - Parameter child: the child node.
    @discardableResult
    public final func removeChild(_ child: ChildNode) -> ChildNode? {
        guard let index: Int = children.firstIndex(where: { $0 === child }) else {
            return nil
        }
        return removeChild(at: index)
    }

    /// Remove all children from this node.
    public final func removeAllChildren() {
        children.forEach { $0.parent = nil }
        children.removeAll()
    }

    /// Descends the node's children breadth-first, applying the given closure to this node and all it's children.
    ///
    /// - Parameter applyToNode: The closure to apply.
    public final func descend(_ applyToNode: (CurrentNode) throws -> Void) rethrows {
        try applyToNode(self)
        try children.forEach { try $0.descend(applyToNode) }
    }

    /// Ascends the node's parent, applying given closure to this node first.
    ///
    /// - Parameter applyToNode: The closure to apply.
    public final func ascend(_ applyToNode: (CurrentNode) -> Void) {
        applyToNode(self)
        parent?.ascend(applyToNode)
    }

    /// Descends the node's children breadth-first, applying the given closure to this node while reducing the result
    /// for it and all it's children.
    ///
    /// - Parameters:
    ///   - initialValue: The initial value.
    ///   - applyToNode: The closure to apply.
    /// - Returns: The reduced result.
    public final func descendReduce<Result>(_ initialValue: Result, _ applyToNode: (Result, CurrentNode) throws -> Result) rethrows -> Result {
        var result: Result = try applyToNode(initialValue, self)
        result = try children.reduce(result) {
            try $1.descendReduce($0, applyToNode)
        }
        return result
    }

    /// Ascends the node's parent, applying the given closure to this node while reducing the result for it
    /// and and it's parent.
    ///
    /// - Parameters:
    ///   - initialValue: The initial value.
    ///   - applyToNode: The closure to apply.
    /// - Returns: The reduced result.
    public final func ascendReduce<Result>(_ initialValue: Result, _ applyToNode: (Result, CurrentNode) throws -> Result) rethrows -> Result {
        var result: Result = try applyToNode(initialValue, self)
        if let parent = parent {
            result = try parent.ascendReduce(result, applyToNode)
        }
        return result
    }

    /// Update this node and all it's children.
    public final func update() {
        // See if we should process everyone
        // Update transforms from parent
        performUpdateFromParent()

        // Update all children needing update.
        for child in childrenNeedingUpdate() {
            child.update()
        }
    }

    /// Triggers the node to update its state.
    ///
    /// This method is called internally to ask the node to update it's state
    /// based on its parents state.
    internal final func performUpdateFromParent() {
        updateFromParent()
    }

    /// Class-specific implementation of updateFromParent.
    ///
    /// Splitting the implementation of the update away from the update call
    /// itself allows the detail to be overridden without disrupting the
    /// general sequence of updateFromParent (e.g. raising events).
    open func updateFromParent() {
    }

    open func childrenNeedingUpdate() -> AnyIterator<ChildNode> {
        AnyIterator(children.makeIterator())
    }
}

// MARK: Equatable
extension Node: Equatable where Content: Equatable {
    public static func == (lhs: Node<Content>, rhs: Node<Content>) -> Bool {
        lhs.content == rhs.content
    }
}

// MARK: Comparable
extension Node: Comparable where Content: Comparable {
    public static func < (lhs: Node<Content>, rhs: Node<Content>) -> Bool {
        lhs.content < rhs.content
    }
}

// MARK: CustomStringConvertible
extension Node: CustomStringConvertible {
    open var description: String {
        "<\(type(of: self))>"
    }
}

// MARK: CustomDebugStringConvertible
extension Node: CustomDebugStringConvertible {
    open var debugDescription: String {
        "<\(type(of: self)) \(content)>"
    }
}

// MARK: Recursive description
extension Node {
    /// Recursively descripes this node and all it's children.
    public var descriptionDescending: String {
        describeDescending(self) { $0.description }
    }

    /// Recursively debug descripes this node and all it's children.
    public var debugDescriptionDescending: String {
        describeDescending(self) { $0.debugDescription }
    }

    /// Recursively describe given node and all it's children using a given closure.
    /// - Parameter node: the start node.
    /// - Parameter level: current indentation level.
    /// - Parameter closure: a closure to apply for each node.
    public func describeDescending(_ node: Node<Content>, _ level: Int = 0, using closure: (Node<Content>) -> String) -> String {
        let prefix = String(repeating: "   ", count: level) + "⮑ "
        return prefix + closure(node) + "\n" + self.children.map { $0.describeDescending($0, level + 1, using: closure) }.joined()
    }
}

extension Node where Content == Void {
    public convenience init() {
        self.init(())
    }
}
