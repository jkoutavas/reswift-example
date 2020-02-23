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
    
    @IBAction func addEmployee(_ sender: AnyObject) {
        let targetRow = store?.state.job.items.count ?? 0
        store?.dispatch(InsertEmployeeAction(employee: Employee.empty, index: targetRow))
        store?.dispatch(SelectionAction.select(row: targetRow))
    }
}
