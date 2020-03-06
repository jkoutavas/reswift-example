//
//  RemoveIdempotentActionsMiddleware.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/18/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation
import ReSwift

/// Consumes some actions that don't change the state.
///
/// This is not the most scalable and useful middleware
/// but it serves to demonstrate how you can interrupt the action handling chain.
///
// TODO: stop firing events when the view knows nothing has changed.
let removeIdempotentActionsMiddleware: Middleware<JobState> = { _, getState in
    { next in
        { action in

            guard let state = getState() else {
                next(action)
                return
            }

            if let action = action as? RenameJobAction,
                action.newName == state.job.title {
                print("Ignoring \(action)")

                return
            } else if case let EmployeeAction.rename(employeeID, name: name) = action,
                let employee = state.job.employee(employeeID: employeeID),
                employee.name == name {
                print("Ignoring \(action)")

                return
            } else if let action = action as? SelectionAction,
                action.selectionState == state.selection {
                print("Ignoring \(action)")

                return
            }

            return next(action)
        }
    }
}
