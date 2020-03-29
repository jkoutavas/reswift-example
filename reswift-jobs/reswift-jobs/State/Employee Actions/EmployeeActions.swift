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
    case editRoles(EmployeeID, roles: [String])

    // MARK: Undoable

    var isUndoable: Bool { return true }

    var name: String {
        switch self {
        case .rename: return "Rename Employee"
        case .editRoles: return "Edit Roles"
        }
    }

    func inverse(context: UndoActionContext) -> UndoableAction? {
        switch self {
        case .rename(let employeeID, name: _):
            guard let oldName = context.employeeName(employeeID: employeeID) else { return nil }
            return EmployeeAction.rename(employeeID, name: oldName)

        case .editRoles(let employeeID, roles: _):
            guard let oldRoles = context.employeeRoles(employeeID: employeeID) else { return nil }
            return EmployeeAction.editRoles(employeeID, roles: oldRoles)
        }
    }
}
