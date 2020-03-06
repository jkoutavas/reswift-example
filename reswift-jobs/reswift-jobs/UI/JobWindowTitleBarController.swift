//
//  JobWindowTitleBarController.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/23/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class JobWindowTitleBarController: NSTitlebarAccessoryViewController {
    var store: JobStore?

    @IBAction func addEmployee(_: AnyObject) {
        guard let store = store else { return }
        let targetRow = store.state.job.items.count
        store.dispatch(InsertEmployeeAction(employee: Employee.empty, index: targetRow))

        // TODO: One could easily argue that selection is not an action appropriate to an add button.
        // It makes an assumption about UI rendering. Consider moving the selection to elsewhere.
        store.dispatch(SelectionAction.select(row: targetRow))
    }
}
