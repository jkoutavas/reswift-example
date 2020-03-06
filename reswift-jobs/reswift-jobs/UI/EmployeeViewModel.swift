//
//  EmployeeViewModel.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

protocol DisplaysEmployee {
    func showEmployee(employeeViewModel viewModel: EmployeeViewModel)
}

struct EmployeeViewModel {
    let identifier: String

    let name: String
    let skills: [String]
}
