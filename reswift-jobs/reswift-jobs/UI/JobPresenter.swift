//
//  JobPresenter.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation
import ReSwift

class JobPresenter {
    typealias View = DisplaysJob

    let view: View

    init(view: View) {
        self.view = view
    }
}

extension EmployeeViewModel {
    init(employee: Employee) {
        identifier = employee.employeeID.identifier
        name = employee.name
        roles = employee.roles
    }
}

extension JobPresenter: StoreSubscriber {
    func newState(state: JobState) {
        let employeeViewModels = state.job.employees.map(EmployeeViewModel.init)
        let jobViewModel = JobViewModel(
            title: state.job.title ?? "",
            employees: employeeViewModels,
            selectedRow: state.selection
        )

        view.displayJob(jobViewModel: jobViewModel)
    }
}
