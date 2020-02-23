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
 
    fileprivate func dispatchAction(_ action: Action) {
        store?.dispatch(action)
    }
    
    @IBAction func addEmployee(_ sender: AnyObject) {
        let targetRow = store?.state.job.items.count ?? 0
        dispatchAction(InsertEmployeeAction(employee: Employee.empty, index: targetRow))
        dispatchAction(SelectionAction.select(row: targetRow))
    }
}
