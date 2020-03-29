//
//  JobViewModel.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

struct JobViewModel {
    let title: String
    let employees: [EmployeeViewModel]
    var itemCount: Int { return employees.count }

    let selectedRow: Int?
    var selectedEmployee: EmployeeViewModel? {
        guard let selectedRow = selectedRow else { return nil }
        return employees[selectedRow]
    }
}
