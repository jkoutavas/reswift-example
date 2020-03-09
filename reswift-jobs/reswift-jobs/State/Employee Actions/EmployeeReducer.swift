//
//  EmployeeReducer.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/17/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import ReSwift

func employeeReducer(_ action: Action, state: Employee?) -> Employee? {
    guard let action = action as? EmployeeAction,
        let employee = state
    else { return state }

    return handleEmployeeAction(action, employee: employee)
}

private func handleEmployeeAction(_ action: EmployeeAction, employee: Employee) -> Employee {
    var employee = employee

    switch action {
    case let .rename(employeeID, name: name):
        guard employee.employeeID == employeeID else { return employee }
        employee.name = name
    case let .editSkills(employeeID, skills: skills):
        guard employee.employeeID == employeeID else { return employee }
        employee.skills = skills
    }

    return employee
}
