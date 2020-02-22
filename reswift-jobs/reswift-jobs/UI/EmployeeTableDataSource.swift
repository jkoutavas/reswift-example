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
        return employeeCount
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        guard let viewModel = viewModel?.items[index] else {
            return EmployeeViewModel(identifier:"unknown", name:"unknown", skills:"unknown")
        }
           
        return viewModel
    }
}

extension EmployeeTableDataSource: EmployeeTableDataSourceType {
    var selectedRow: Int? { return viewModel?.selectedRow }
    var selectedEmployee: EmployeeViewModel? { return viewModel?.selectedEmployee }
    var employeeCount: Int { return viewModel?.itemCount ?? 0 }
    
    func updateContents(jobViewModel viewModel: JobViewModel) {
        self.viewModel = viewModel
    }
}
