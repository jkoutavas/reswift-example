//
//  EmployeeTableDataSourceTests.swift
//  reswift-jobsTests
//
//  Created by Jay Koutavas on 3/28/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

@testable import reswift_jobs
import XCTest

class EmployeeTableDataSourceTests: XCTestCase {
    let irrelevantTableView = NSTableView()

    func testNumberOfRows_WithoutVM_Returns0() {
        let dataSource = EmployeeTableDataSource()

        XCTAssertEqual(dataSource.numberOfRows(in: irrelevantTableView), 0)
    }

    func testNumberOfRows_WithVM_ReturnsVMItemCount() {
        let dataSource = EmployeeTableDataSource()
        let employees = (0 ... 3).map(String.init)
            .map { EmployeeViewModel(identifier: $0, name: $0, skills: []) }
        let viewModel = JobViewModel(title: "irrelevant", employees: employees, selectedRow: nil)

        dataSource.updateContents(jobViewModel: viewModel)

        XCTAssertEqual(dataSource.numberOfRows(in: irrelevantTableView), employees.count)
    }
}
