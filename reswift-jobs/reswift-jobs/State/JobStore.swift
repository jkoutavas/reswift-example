//
//  JobStore.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/10/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation
import ReSwift

typealias JobStore = Store<JobState>

/// Generic action which can be dispatched.
/// - Note: Use `UndoableAction` for most UI events instead.
typealias Action = ReSwift.Action

// A typealias will not work and only raise EXC_BAD_ACCESS exceptions. ¯\_(ツ)_/¯
protocol UndoableAction: Action, Undoable {}

func jobStore(undoManager: UndoManager) -> JobStore {
    return JobStore(
        reducer: jobReducer,
        state: nil,
        middleware: [
            removeIdempotentActionsMiddleware,
            loggingMiddleware,
            undoMiddleware(undoManager: undoManager)
        ]
    )
}
