//
//  JobTests.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 3/29/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import XCTest
@testable import reswift_jobs

class JobTests: XCTestCase {

    func testEqualContent_WithDifferentTitles_ReturnsFalse() {

        let employees = [Employee(name: "irrelevant")]

        XCTAssertFalse(Job(title: "a", employees: employees).hasEqualContent(Job(title: "b", employees: employees)))
    }

    func testEqualContent_WithDifferentEmployees_ReturnsFalse() {

        let oneEmployees = [Employee(name: "one")]
        let otherEmployees = [Employee(name: "other")]

        XCTAssertFalse(Job(title: "a", employees: oneEmployees).hasEqualContent(Job(title: "a", employees: otherEmployees)))
    }

    func testEqualContent_With1ContentEqualemployee_ReturnsTrue() {

        let employeeID = EmployeeID()
        let oneEmployees = [Employee(employeeID: employeeID, name: "same")]
        let otherEmployees = [Employee(employeeID: employeeID, name: "same")]

        XCTAssertTrue(Job(title: "a", employees: oneEmployees).hasEqualContent(Job(title: "a", employees: otherEmployees)))
    }

    func testEqualContent_With1ContentEqualemployeeButDifferentCountsLeft_ReturnsFalse() {

        let oneEmployees = [Employee(name: "same")]
        let otherEmployees = [
            Employee(name: "same"),
            Employee(name: "other")
        ]

        XCTAssertFalse(Job(title: "a", employees: oneEmployees).hasEqualContent(Job(title: "a", employees: otherEmployees)))
    }

    func testEqualContent_With1ContentEqualemployeeButDifferentCountsRight_ReturnsFalse() {

        let oneEmployees = [
            Employee(name: "same"),
            Employee(name: "other")
        ]
        let otherEmployees = [
            Employee(name: "same")
        ]

        XCTAssertFalse(Job(title: "a", employees: oneEmployees).hasEqualContent(Job(title: "a", employees: otherEmployees)))
    }

    func testEqualContent_WithContentEqualemployeesPlusDifference_ReturnsFalse() {

        let oneEmployees = [
            Employee(name: "same"),
            Employee(name: "different")
        ]
        let otherEmployees = [
            Employee(name: "same"),
            Employee(name: "unlike")
        ]

        XCTAssertFalse(Job(title: "a", employees: oneEmployees).hasEqualContent(Job(title: "a", employees: otherEmployees)))
    }

    func testEqualContent_WithContentEqualDuplicateemployees_ReturnsFalse() {

        let oneEmployees = [
            Employee(name: "same"),
            Employee(name: "same")
        ]
        let otherEmployees = [
            Employee(name: "same"),
            Employee(name: "unlike")
        ]

        XCTAssertFalse(Job(title: "a", employees: oneEmployees).hasEqualContent(Job(title: "a", employees: otherEmployees)))
    }

    // MARK: Adding employees

    func testAddEmployee_EmptyJob_AddsEmployee() {

        let employee = Employee(name: "an employee")
        var job = Job.empty

        job.addEmployee(employee)

        let expectedJob = Job(title: nil, employees: [employee])
        XCTAssertEqual(job, expectedJob)
    }

    func testAddEmployee_JobWithEmployee_AddsEmployeeToEnd() {

        let newEmployee = Employee(name: "new employee")
        let existingEmployee = Employee(name: "existing employee")
        var job = Job(title: nil, employees: [existingEmployee])

        job.addEmployee(newEmployee)

        let expectedJob = Job(title: nil, employees: [existingEmployee, newEmployee])
        XCTAssertEqual(job, expectedJob)
        let wronglySortedJob = Job(title: nil, employees: [newEmployee, existingEmployee])
        XCTAssertNotEqual(job, wronglySortedJob)
    }

    func testInsertEmployee_EmptyJob_At0_AddsEmployee() {

        let employee = Employee(name: "an employee")
        var job = Job.empty

        job.insertEmployee(employee, atIndex: 0)

        let expectedJob = Job(title: nil, employees: [employee])
        XCTAssertEqual(job, expectedJob)
    }

    func testInsertEmployee_EmptyJob_AtNegativeValue_AddsEmployee() {

        let employee = Employee(name: "an employee")
        var job = Job.empty

        job.insertEmployee(employee, atIndex: -123)

        let expectedJob = Job(title: nil, employees: [employee])
        XCTAssertEqual(job, expectedJob)
    }

    func testInsertEmployee_EmptyJob_At1000_AddsEmployee() {

        let employee = Employee(name: "an employee")
        var job = Job.empty

        job.insertEmployee(employee, atIndex: 1000)

        let expectedJob = Job(title: nil, employees: [employee])
        XCTAssertEqual(job, expectedJob)
    }

    func testInsertEmployee_JobWithEmployee_AtNegativeValue_AddsEmployeeToBeginning() {

        let newEmployee = Employee(name: "new employee")
        let existingEmployee = Employee(name: "existing employee")
        var job = Job(title: nil, employees: [existingEmployee])

        job.insertEmployee(newEmployee, atIndex: -999)

        let expectedJob = Job(title: nil, employees: [newEmployee, existingEmployee])
        XCTAssertEqual(job, expectedJob)
        let wronglySortedJob = Job(title: nil, employees: [existingEmployee, newEmployee])
        XCTAssertNotEqual(job, wronglySortedJob)
    }

    func testInsertEmployee_JobWithEmployee_At0_AddsEmployeeToBeginning() {

        let newEmployee = Employee(name: "new employee")
        let existingEmployee = Employee(name: "existing employee")
        var job = Job(title: nil, employees: [existingEmployee])

        job.insertEmployee(newEmployee, atIndex: 0)

        let expectedJob = Job(title: nil, employees: [newEmployee, existingEmployee])
        XCTAssertEqual(job, expectedJob)
        let wronglySortedJob = Job(title: nil, employees: [existingEmployee, newEmployee])
        XCTAssertNotEqual(job, wronglySortedJob)
    }

    func testInsertEmployee_JobWithEmployee_AtHighValue_AddsEmployeeToEnd() {

        let newEmployee = Employee(name: "new employee")
        let existingEmployee = Employee(name: "existing employee")
        var job = Job(title: nil, employees: [existingEmployee])

        job.insertEmployee(newEmployee, atIndex: 123)

        let expectedJob = Job(title: nil, employees: [existingEmployee, newEmployee])
        XCTAssertEqual(job, expectedJob)
        let wronglySortedJob = Job(title: nil, employees: [newEmployee, existingEmployee])
        XCTAssertNotEqual(job, wronglySortedJob)
    }

    func testInsertEmployee_JobWith2employees_At1_AddsEmployeeInBetween() {

        let newEmployee = Employee(name: "new employee")
        let firstEmployee = Employee(name: "existing employee")
        let secondEmployee = Employee(name: "another existing employee")
        var job = Job(title: nil, employees: [firstEmployee, secondEmployee])

        job.insertEmployee(newEmployee, atIndex: 1)

        let expectedJob = Job(title: nil, employees: [firstEmployee, newEmployee, secondEmployee])
        XCTAssertEqual(job, expectedJob)
    }

    // MARK: Removing employees

    func testRemoveEmployee_employeeWithDifferentID_ReturnsUnchangedJob() {

        let existingEmployee = Employee(employeeID: EmployeeID(), name: "irrelevant")
        var job = Job(title: nil, employees: [existingEmployee])

        job.removeEmployee(employeeID: EmployeeID())

        let expectedJob = Job(title: nil, employees: [existingEmployee])
        XCTAssertEqual(job, expectedJob)
    }

    func testRemoveEmployee_employeeWithSameID_ReturnsEmptyJob() {

        let employeeID = EmployeeID()
        let existingEmployee = Employee(employeeID: employeeID, name: "irrelevant")
        var job = Job(title: nil, employees: [existingEmployee])

        job.removeEmployee(employeeID: employeeID)

        XCTAssertEqual(job, Job.empty)
    }

    func testRemoveEmployee_OneOf2employeesWithSameID_ReturnsJobWithOtheremployeeLeft() {

        let employeeID = EmployeeID()
        let matchingEmployee = Employee(employeeID: employeeID, name: "irrelevant")
        let unmatchingEmployee = Employee(employeeID: EmployeeID(), name: "also irrelevant")
        var job = Job(title: nil, employees: [matchingEmployee, unmatchingEmployee])

        job.removeEmployee(employeeID: employeeID)

        let expectedJob = Job(title: nil, employees: [unmatchingEmployee])
        XCTAssertEqual(job, expectedJob)
    }
}
