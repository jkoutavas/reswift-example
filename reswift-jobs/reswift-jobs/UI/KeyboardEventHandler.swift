//
//  KeyboardEventHandler.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 3/3/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class KeyboardEventHandler: PatchingResponder {
    var store: JobStore?
    var dataSource: EmployeeTableDataSourceType!

    // MARK: Selection

    override func cancelOperation(_: Any?) {
        store?.dispatch(SelectionAction.deselect)
    }

    override func moveUp(_: Any?) {
        let newRow: Int = {
            guard let selectedRow = dataSource.selectedRow, selectedRow > 0
            else { return dataSource.employeeCount - 1 }

            return selectedRow - 1
        }()

        store?.dispatch(SelectionAction.select(row: newRow))
    }

    override func moveDown(_: Any?) {
        let newRow: Int = {
            guard let selectedRow = dataSource.selectedRow, selectedRow < (dataSource.employeeCount - 1)
            else { return 0 }

            return selectedRow + 1
        }()

        store?.dispatch(SelectionAction.select(row: newRow))
    }

    // MARK: Editing

    // TODO:

    // MARK: Removal

    override func deleteForward(_: Any?) {
        removeSelectedEmployee()
    }

    override func deleteBackward(_: Any?) {
        removeSelectedEmployee()
    }

    fileprivate func removeSelectedEmployee() {
        guard let selectedEmployee = dataSource.selectedEmployee,
            let employeeID = EmployeeID(identifier: selectedEmployee.identifier)
        else { return }

        store?.dispatch(RemoveEmployeeAction(employeeID: employeeID))
    }
}
