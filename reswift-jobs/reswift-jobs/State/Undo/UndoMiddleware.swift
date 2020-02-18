//
//  UndoMiddleware.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/17/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation
import ReSwift

class UndoableStateAdapter: UndoActionContext {

    let state: JobState

    init(jobState: JobState) {

        self.state = jobState
    }

    var jobTitle: String? { return state.job.title }

    func employeeName(employeeID: EmployeeID) -> String? {

        return state.job.employee(employeeID: employeeID)?.name
    }

    func jobIn(employeeID: EmployeeID) -> JobIn? {

        guard let index = state.job.indexOf(employeeID: employeeID),
            let employee = state.job.employee(employeeID: employeeID)
            else { return nil }

        return (employee, index)
    }
}

extension UndoCommand {

    convenience init?(appAction: UndoableAction, context: UndoActionContext, dispatch: @escaping DispatchFunction) {

        guard let inverseAction = appAction.inverse(context: context)
            else { return nil }

        self.init(undoBlock: { _ = dispatch(inverseAction.notUndoable) },
                  undoName: appAction.name,
                  redoBlock: { _ = dispatch(appAction.notUndoable) })
    }
}

func undoMiddleware(undoManager: UndoManager) -> Middleware<JobState> {

    func undoAction(action: UndoableAction, state: JobState, dispatch: @escaping DispatchFunction) -> UndoCommand? {

        let context = UndoableStateAdapter(jobState: state)

        return UndoCommand(appAction: action, context: context, dispatch: dispatch)
    }

    let undoMiddleware: Middleware<JobState> = { dispatch, getState in
        return { next in
            return { action in

                // Pass already undone actions through
                if let undoneAction = action as? NotUndoable {
                    next(undoneAction.action)
                    return
                }

                if let undoableAction = action as? UndoableAction , undoableAction.isUndoable,
                    let state = getState(),
                    let undo = undoAction(action: undoableAction, state: state, dispatch: dispatch) {

                    undo.register(undoManager: undoManager)
                }


                next(action)
            }
        }
    }
    
    return undoMiddleware
}
