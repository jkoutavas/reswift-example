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
        self.identifier = employee.employeeID.identifier
        self.name = employee.name
        self.skills = employee.skills
    }
}

extension JobPresenter: StoreSubscriber {

    func newState(state: JobState) {
        let itemViewModels = state.job.items.map(EmployeeViewModel.init)
        let viewModel = JobViewModel(
            title: state.job.title ?? "",
            items: itemViewModels,
            selectedRow: state.selection)

        view.displayJob(jobViewModel: viewModel)
    }
}

