//
//  EmployeeActions.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/17/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

enum EmployeeAction: UndoableAction {

    case rename(EmployeeID, name: String)

    // MARK: Undoable

    var isUndoable: Bool { return true }

    var name: String {
        switch self {
        case .rename: return "Rename Employee"
        }
    }

    func inverse(context: UndoActionContext) -> UndoableAction? {

        switch self {
        case .rename(let employeeID, name: _):
            guard let oldName = context.employeeName(employeeID: employeeID) else { return nil }
            return EmployeeAction.rename(employeeID, name: oldName)
        }
    }
}
