//
//  JobActions.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/16/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation
import ReSwift

protocol JobAction: Action {

    func apply(oldJob: Job) -> Job
}

struct RenameJobAction: UndoableAction, JobAction {

    let newName: String?

    init(renameTo newName: String?) {

        self.newName = newName
    }

    func apply(oldJob: Job) -> Job {

        var result = oldJob
        result.title = self.newName
        return result
    }

    var name: String { return "Rename Job" }
    var isUndoable: Bool { return true }

    func inverse(context: UndoActionContext) -> UndoableAction? {

        let oldName = context.jobTitle
        return RenameJobAction(renameTo: oldName)
    }
}

struct ReplaceJobAction: JobAction {

    let newJob: Job

    func apply(oldJob: Job) -> Job {

        return newJob
    }
}

struct InsertTaskAction: UndoableAction, JobAction {

    let employee: Employee
    let index: Int

    func apply(oldJob: Job) -> Job {

        var result = oldJob
        result.insertItem(employee, atIndex: index)
        return result
    }

    var isUndoable: Bool { return true }
    var name: String { return "Append Task" }

    func inverse(context: UndoActionContext) -> UndoableAction? {

        return RemoveTaskAction(employeeID: employee.employeeID)
    }
}

struct RemoveTaskAction: UndoableAction, JobAction {

    let employeeID: EmployeeID

    func apply(oldJob: Job) -> Job {

        var result = oldJob
        result.removeItem(employeeID: employeeID)
        return result
    }

    var isUndoable: Bool { return true }
    var name: String { return "Remove Task" }

    func inverse(context: UndoActionContext) -> UndoableAction? {

        guard let removingEmployee = context.jobIn(employeeID: employeeID) else { return nil }

        return InsertTaskAction(employee: removingEmployee.employee, index: removingEmployee.index)
    }
}
