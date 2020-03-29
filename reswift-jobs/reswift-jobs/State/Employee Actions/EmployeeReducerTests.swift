//
//  EmployeeReducerTests.swift
//  reswift-jobsTests
//
//  Created by Jay Koutavas on 3/22/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import XCTest
import ReSwift
@testable import reswift_jobs

// swiftlint:disable nesting

class EmployeeReducerTests: XCTestCase {

    func testHandleAction_WithUnsupportedActionAndNil_ReturnsNil() {

        struct SomeAction: Action { }

        XCTAssertNil(employeeReducer(SomeAction(), state: nil))
    }

    func testHandleAction_WithUnsupportedActionAndState_ReturnsState() {

        struct SomeAction: Action { }
        let state = Employee(name: "Bob Smith", skills: ["Foreman"])

        let result = employeeReducer(SomeAction(), state: state)

        XCTAssertEqual(result, state)
    }

    func testHandleAction_WithRenameAction_ItemWithDifferentID_ReturnsSameItem() {

        let originalName = "old name"
        let item = Employee(employeeID: EmployeeID(), name: originalName)

        let result = employeeReducer(EmployeeAction.rename(EmployeeID(), name: "new name!!1"), state: item)

        XCTAssertNotNil(result)
        if let result = result {
            XCTAssertEqual(result, item)
        }
    }
}
