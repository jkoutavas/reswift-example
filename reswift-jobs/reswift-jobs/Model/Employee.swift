//
//  Employee.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

struct Employee {
    static var empty: Employee { return Employee(name: "New Employee", skills:"{skills}") }

    let employeeID: EmployeeID
    var name: String
    var skills: String
    
    init(employeeID: EmployeeID = EmployeeID(), name: String, skills: String) {

        self.employeeID = employeeID
        self.name = name
        self.skills = skills
    }
}

// MARK: Employee (sub)type equatability

extension Employee: Equatable {

    /// Equality check ignoring the `EmployeeID`.
    func hasEqualContent(_ other: Employee) -> Bool {

        return name == other.name && skills == other.skills
    }
}

func ==(lhs: Employee, rhs: Employee) -> Bool {

    return lhs.employeeID == rhs.employeeID && lhs.name == rhs.name && lhs.skills == rhs.skills
}
