//
//  EmployeeTableDataSource.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/21/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class EmployeeTableDataSource: NSObject {

    var viewModel: JobViewModel?
}

extension EmployeeTableDataSource: NSOutlineViewDataSource {

    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        // TODO
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        // TODO
    }
}

extension EmployeeTableDataSource: EmployeeTableDataSourceType {
    var selectedRow: Int? { return viewModel?.selectedRow }
    var selectedEmployee: EmployeeViewModel? { return viewModel?.selectedEmployee }
    var employeeCount: Int { return viewModel?.itemCount ?? 0 }
    
    func updateContents(jobViewModel viewModel: JobViewModel) {

        self.viewModel = viewModel
    }

    func employeeCellView(tableView: NSOutlineView, row: Int, owner: AnyObject) -> EmployeeCellView? {

        guard let cellViewModel = viewModel?.items[row],
            let cellView = EmployeeCellView.make(tableView: tableView, owner: owner)
            else { return nil }

        cellView.showEmployee(employeeViewModel: cellViewModel)

        return cellView
    }
}
