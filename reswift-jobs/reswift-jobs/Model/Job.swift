//
//  Job.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

struct Job: Codable {
    static var empty: Job { return Job(title: nil, employees: []) }

    var title: String?
    var employees: [Employee]

    var isEmpty: Bool {
        return (title?.isEmpty ?? true) && employees.isEmpty
    }

    mutating func addEmployee(_ employee: Employee) {
        employees.append(employee)
    }

    /// Always inserts `employee` into the list:
    ///
    /// - if `index` exceeds the bounds of the employees collection,
    ///   it will be appended or prepended;
    /// - if `index` falls inside these bounds, it will be
    ///   inserted between existing elements.
    mutating func insertEmployee(_ employee: Employee, atIndex index: Int) {
        if index < 1 {
            employees.insert(employee, at: 0)
        } else if index < employees.count {
            employees.insert(employee, at: index)
        } else {
            employees.append(employee)
        }
    }

    mutating func moveEmployees(from: Int, to: Int) {
        employees.move(from: from, to: to)
    }

    func indexOf(employeeID: EmployeeID) -> Int? {
        return employees.firstIndex(where: { $0.employeeID == employeeID })
    }

    func employee(employeeID: EmployeeID) -> Employee? {
        guard let index = indexOf(employeeID: employeeID)
        else { return nil }

        return employees[index]
    }

    mutating func removeEmployee(employeeID: EmployeeID) {
        guard let index = indexOf(employeeID: employeeID)
        else { return }

        employees.remove(at: index)
    }
}

extension Job {
    init() {
        title = nil
        employees = []
    }

    static func demoJob() -> Job {
        let employees = [
            Employee(name: "Bob Smith", skills: ["foreman", "electrician"]),
            Employee(name: "Jane Doe", skills: ["surveyor", "accountant"])
        ]

        return Job(title: "Remodel garage", employees: employees)
    }
}

extension Job: Equatable {
    /// Equality check ignoring the `employees`'s EmployeeID`s.
    func hasEqualContent(_ other: Job) -> Bool {
        guard title == other.title else { return false }
        guard employees.count == other.employees.count else { return false }

        for employee in employees {
            guard other.employees.contains(where: { $0.hasEqualContent(employee) }) else {
                return false
            }
        }

        for employee in other.employees {
            guard employees.contains(where: { $0.hasEqualContent(employee) }) else {
                return false
            }
        }

        return true
    }
}

func == (lhs: Job, rhs: Job) -> Bool {
    return lhs.title == rhs.title && lhs.employees == rhs.employees
}
