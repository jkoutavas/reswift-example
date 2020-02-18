//
//  JobsReducer.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/16/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import ReSwift

func jobReducer(action: Action, state: JobState?) -> JobState {


    // Nil state is only relevant on first launch, so
    // return a demo job for starters.
    guard var state = state else {
        return JobState()
    }

    var job = state.job
    job = passActionToList(action, job: job)
    job = passActionToItems(action, job: job)
    state.job = job

    state.selection = passActionToSelection(action, selectionState: state.selection)

    return state
}

private func passActionToList(_ action: Action, job: Job) -> Job {

    guard let action = action as? JobAction else { return job }

    return action.apply(oldJob: job)
}

private func passActionToItems(_ action: Action, job: Job) -> Job {

    var job = job

    job.items = job.items.compactMap { employeeReducer(action, state: $0) }

    return job
}

private func passActionToSelection(_ action: Action, selectionState: SelectionState) -> SelectionState {

    return selectionReducer(action, state: selectionState)
}
