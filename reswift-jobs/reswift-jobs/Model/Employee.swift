//
//  Employee.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

struct Employee: Codable {
    static var empty: Employee { return Employee(name: "New Employee", skills: ["skill1", "skill2"]) }

    let employeeID: EmployeeID
    var name: String
    var skills: [String]

    init(employeeID: EmployeeID = EmployeeID(), name: String, skills: [String] = []) {
        self.employeeID = employeeID
        self.name = name
        self.skills = skills
    }
}

// MARK: Employee (sub)type equatability

extension Employee: Equatable {
    func hasEqualContent(_ other: Employee) -> Bool {
        return self == other
    }
}

func == (lhs: Employee, rhs: Employee) -> Bool {
    /// Equality check ignoring skills
    return lhs.employeeID == rhs.employeeID && lhs.name == rhs.name
}
