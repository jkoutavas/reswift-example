//
//  EmployeeID.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

struct EmployeeID: Codable {
    let identifier: String

    init() {
        identifier = UUID().uuidString
    }

    init(UUID: Foundation.UUID) {
        identifier = UUID.uuidString
    }

    init?(identifier: String) {
        guard let UUID = UUID(uuidString: identifier) else {
            return nil
        }

        self.identifier = UUID.uuidString
    }
}

extension EmployeeID: Equatable {}

func == (lhs: EmployeeID, rhs: EmployeeID) -> Bool {
    return lhs.identifier == rhs.identifier
}

extension EmployeeID: Hashable {}

extension EmployeeID: CustomStringConvertible {
    var description: String { return identifier }
}
