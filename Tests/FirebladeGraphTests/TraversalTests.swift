//
//  TraversalTests.swift
//  
//
//  Created by Christian Treffs on 22.08.19.
//

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import FirebladeUUID
import FirebladeGraph

final class TraversalTests: XCTestCase {
    func testDescendLinearGraph() {
        
        let a = Node()
        let b = Node()
        let c = Node()
        let d = Node()
        let e = Node()
        let f = Node()
        let g = Node()
        let h = Node()
        let i = Node()
        let j = Node()
        
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
        
        a.descend {
            result.append($0.uuid)
        }
        
        let expected = [a,b,c,d,e,f,g,h,i,j].map { $0.uuid }
        XCTAssertEqual(result, expected)
    }
    
    func testDescendSpreadingGraph() {
        
        let a = Node()
        let b = Node()
        let c = Node()
        let d = Node()
        let e = Node()
        let f = Node()
        let g = Node()
        let h = Node()
        let i = Node()
        let j = Node()
        
        a.addChild(b)
        
        b.addChild(c)
        b.addChild(d)
        
        c.addChild(e)
        c.addChild(f)
        c.addChild(g)
        
        d.addChild(h)
        d.addChild(i)
        d.addChild(j)
        
        var result: [UUID] = []
        
        a.descend {
            result.append($0.uuid)
        }
        let expected = [a,b,c,e,f,g,d,h,i,j].map { $0.uuid }
        XCTAssertEqual(result, expected)
    }
    
    func testDescendReduceLinearGraph() {
        
        let a = Node()
        let b = Node()
        let c = Node()
        let d = Node()
        let e = Node()
        let f = Node()
        let g = Node()
        let h = Node()
        let i = Node()
        let j = Node()
        
        a.addChild(b)
        b.addChild(c)
        c.addChild(d)
        d.addChild(e)
        e.addChild(f)
        f.addChild(g)
        g.addChild(h)
        h.addChild(i)
        i.addChild(j)
        
        let result: [UUID] = a.descendReduce([UUID]()) { $0 + [$1.uuid] }
        
        let expected = [a,b,c,d,e,f,g,h,i,j].map { $0.uuid }
        XCTAssertEqual(result, expected)
    }
    
    
    
    
    func testAscendLinearGraph() {
        
        let a = Node()
        let b = Node()
        let c = Node()
        let d = Node()
        let e = Node()
        let f = Node()
        let g = Node()
        let h = Node()
        let i = Node()
        let j = Node()
        
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
            result.append($0.uuid)
        }
        
        let expected = [a,b,c,d,e,f,g,h,i,j].reversed().map { $0.uuid }
        XCTAssertEqual(result, expected)
    }
    
    func testAscendReduceLinearGraph() {
        
        let a = Node()
        let b = Node()
        let c = Node()
        let d = Node()
        let e = Node()
        let f = Node()
        let g = Node()
        let h = Node()
        let i = Node()
        let j = Node()
        
        a.addChild(b)
        b.addChild(c)
        c.addChild(d)
        d.addChild(e)
        e.addChild(f)
        f.addChild(g)
        g.addChild(h)
        h.addChild(i)
        i.addChild(j)
        
        let result: [UUID] = j.ascendReduce([UUID]()) { $0 + [$1.uuid] }
        
        let expected = [a,b,c,d,e,f,g,h,i,j].reversed().map { $0.uuid }
        XCTAssertEqual(result, expected)
    }
    
    
}
