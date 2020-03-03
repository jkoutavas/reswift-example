//
//  Job.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

struct Job {
    var title: String?
    var items: [Employee]

    var isEmpty: Bool {
        return (title?.isEmpty ?? true) && items.isEmpty
    }
    
    mutating func appendItem(_ employee: Employee) {

        items.append(employee)
    }

    /// Always inserts `employee` into the list:
    ///
    /// - if `index` exceeds the bounds of the items collection,
    ///   it will be appended or prepended;
    /// - if `index` falls inside these bounds, it will be
    ///   inserted between existing elements.
    mutating func insertItem(_ employee: Employee, atIndex index: Int) {

        if index < 1 {
            items.insert(employee, at: 0)
        } else if index < items.count {
            items.insert(employee, at: index)
        } else {
            items.append(employee)
        }
    }
    
    mutating func moveItems(from: Int, to: Int) {
        items.move(from: from, to: to)
    }
    
    func indexOf(employeeID: EmployeeID) -> Int? {

        return items.firstIndex(where: { $0.employeeID == employeeID })
    }

    func employee(employeeID: EmployeeID) -> Employee? {

        guard let index = indexOf(employeeID: employeeID)
            else { return nil }

        return items[index]
    }

    mutating func removeItem(employeeID: EmployeeID) {

        guard let index = indexOf(employeeID: employeeID)
            else { return }

        items.remove(at: index)
    }
}

extension Job {
    init() {
        self.title = nil
        self.items = []
    }
    
    static func demoJob() -> Job {

        let employees = [
            Employee(name: "Bob Smith", skills: "foreman, electrician"),
            Employee(name: "Jane Doe", skills: "surveyor, accountant")
        ]

        return Job(title: "Remodel garage", items: employees)
    }
}

extension Job: Equatable {
    /// Equality check ignoring the `items`'s EmployeeID`s.
    func hasEqualContent(_ other: Job) -> Bool {

        guard title == other.title else { return false }
        guard items.count == other.items.count else { return false }

        for employee in items {

            guard other.items.contains(where: { $0.hasEqualContent(employee) }) else {
                return false
            }
        }

        for employee in other.items {

            guard items.contains(where: { $0.hasEqualContent(employee) }) else {
                return false
            }
        }

        return true
    }
}

func ==(lhs: Job, rhs: Job) -> Bool {
    return lhs.title == rhs.title && lhs.items == rhs.items
}
