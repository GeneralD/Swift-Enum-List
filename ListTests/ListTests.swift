//
//  ListTests.swift
//  ListTests
//
//  Created by Yumenosuke Koukata on 2019/10/26.
//  Copyright © 2019 ZYXW. All rights reserved.
//

import XCTest
@testable import List

class ListTests: XCTestCase {

	let l1 = List(1, 1, 2, 3, 5, 8)
	let l2 = List(from: [1, 1, 2, 3, 5, 8])
	let empty = List(from: [Int]())

	func testInitFunc() {
		let l3 = List(from: l1)
		XCTAssertEqual(l3[0], 1)
		XCTAssertEqual(l3[5], 8)
		XCTAssertEqual(l3.count, 6)
	}
	
	func testInitFuncWithManyElement() {
		let l3 = List(from: 0..<50000)
		XCTAssertEqual(l3.count, 50000)
	}
	
    func testL1() {
		XCTAssertEqual(l1[0], 1)
		XCTAssertEqual(l1[5], 8)
		XCTAssertEqual(l1.count, 6)
    }
	
	func testL2() {
		XCTAssertEqual(l2[0], 1)
		XCTAssertEqual(l2[5], 8)
		XCTAssertEqual(l2.count, 6)
	}
	
	func testL1String() {
		XCTAssertEqual("\(l1)", "1, 1, 2, 3, 5, 8")
	}
	
	func testL2String() {
		XCTAssertEqual("\(l2)", "1, 1, 2, 3, 5, 8")
		XCTAssertEqual(l1.description, l2.description)
	}
	
	func testEquatable() {
		XCTAssertEqual(l1, l2)
		XCTAssertNotEqual(l1, empty)
		XCTAssertNotEqual(l1, List.cons(999, l1))
	}

	func testReverse() {
		let a = [111, 222, 333, 555, 789]
		let r1 = List(from: a).reversed()
		let r2 = List(from: a.reversed())
		XCTAssertEqual(r1, r2)
	}
	
	func testDropFirst() {
		let d = l1.dropFirst()
		XCTAssertNotEqual(d, l1)
		let e = d.dropFirst()
		XCTAssertEqual(e.first, 2)
		let emp = e.dropFirst(100)
		XCTAssertEqual(emp, .empty)
	}
	
	func testPlus() {
		XCTAssertEqual(List.empty + List(5, 6), List(5, 6))
		XCTAssertEqual(List(5, 6) + List.empty, List(5, 6))
		XCTAssertEqual(List(0) + l1 + List(13, 21) + List(34), List(0, 1, 1, 2, 3, 5, 8, 13, 21, 34))
	}
	
	func testMap() {
		XCTAssertEqual(l1.map { $0 * $0 }, List(1, 1, 4, 9, 25, 64))
	}
	
	func testFlatMap() {
		XCTAssertEqual(l1.flatMap { List($0, $0 + 1) }, List(1, 2, 1, 2, 2, 3, 3, 4, 5, 6, 8, 9))
	}
	
    func testPerformanceInitFunc1() {
        self.measure {
			_ = List(from: 0..<1000)
        }
    }

	func testPerformanceInitFunc2() {
        self.measure {
			_ = List(from: 0..<10000)
        }
    }
	
	func testPerformanceMap() {
		let l = List(from: 0..<10000)
        self.measure {
			_ = l.map(-)
        }
    }
	
	func testPerformanceReverse() {
		let l = List(from: 0..<10000)
        self.measure {
			_ = l.reversed()
        }
    }
	
	func testPerformanceDropLast() {
		let l = List(from: 0..<10000)
        self.measure {
			_ = l.dropLast()
        }
    }
}
