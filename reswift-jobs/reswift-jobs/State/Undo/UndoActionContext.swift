//
//  UndoActionContext.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/16/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

/// Exposes getters to easily query for the current state when creating
/// an `UndoCommand`.

// TODO: I'm not too keen about having specific data model objects being
// referenced from this seemingly generic "UndoActionContext" module.
// Perhaps it's just a matter of giving this module a data model specific name.

protocol UndoActionContext {
    var jobTitle: String? { get }

    func employeeName(employeeID: EmployeeID) -> String?
    func employeeSkills(employeeID: EmployeeID) -> [String]?
    func jobIn(employeeID: EmployeeID) -> JobIn?
}

typealias JobIn = (employee: Employee, index: Int)
