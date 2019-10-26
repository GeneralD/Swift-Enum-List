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
		let r2 = List(from: a.reversed()).map { $0 }
		XCTAssertEqual(r1, r2)
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
