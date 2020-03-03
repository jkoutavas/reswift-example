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

struct InsertEmployeeAction: UndoableAction, JobAction {

    let employee: Employee
    let index: Int

    func apply(oldJob: Job) -> Job {

        var result = oldJob
        result.insertItem(employee, atIndex: index)
        return result
    }

    var isUndoable: Bool { return true }
    var name: String { return "Add Employee" }

    func inverse(context: UndoActionContext) -> UndoableAction? {

        return RemoveEmployeeAction(employeeID: employee.employeeID)
    }
}

struct RemoveEmployeeAction: UndoableAction, JobAction {

    let employeeID: EmployeeID

    func apply(oldJob: Job) -> Job {

        var result = oldJob
        result.removeItem(employeeID: employeeID)
        return result
    }

    var isUndoable: Bool { return true }
    var name: String { return "Remove Employee" }

    func inverse(context: UndoActionContext) -> UndoableAction? {

        guard let removingEmployee = context.jobIn(employeeID: employeeID) else { return nil }

        return InsertEmployeeAction(employee: removingEmployee.employee, index: removingEmployee.index)
    }
}

struct MoveEmployeeAction: UndoableAction, JobAction {
    let from: Int
    let to: Int
    
    init(from: Int, to: Int) {
        self.from = from
        self.to = to
    }
    
    func apply(oldJob: Job) -> Job {
    
        var result = oldJob
        result.moveItems(from: from, to: to)
        return result
    }
    
    var name: String { return "Move Employee" }
    var isUndoable: Bool { return true }
    
    func inverse(context: UndoActionContext) -> UndoableAction? {

        let movedDown = self.to > self.from
        let inversedFrom = movedDown ? self.to-1 : self.to
        let inversedTo = movedDown ? self.from : self.from+1
         
        return MoveEmployeeAction(from: inversedFrom, to: inversedTo)
    }
}
