//
//  EmployeeTests.swift
//  reswift-jobsTests
//
//  Created by Jay Koutavas on 3/28/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

@testable import reswift_jobs
import XCTest

class EmployeeTests: XCTestCase {
    func testHasEqualContent_WithDifferentName_ReturnsFalse() {
        XCTAssertFalse(Employee(name: "a")
            .hasEqualContent(Employee(name: "b")))
    }

    func testHasEqualContent_WithDifferentSkills_ReturnsTrue() {
        let employee = Employee(name: "a", skills: ["a"])
        var employeeSkilled = employee
        employeeSkilled.skills = ["b"]
        XCTAssertTrue(employee.hasEqualContent(employeeSkilled))
    }

    func testHasEqualContent_WithDifferentIDs_ReturnsFalse() {
        XCTAssertFalse(Employee(employeeID: EmployeeID(), name: "a")
            .hasEqualContent(Employee(employeeID: EmployeeID(), name: "a")))
    }
}
