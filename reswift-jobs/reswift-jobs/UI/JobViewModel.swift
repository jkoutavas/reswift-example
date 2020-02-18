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
    let items: [EmployeeViewModel]
    var itemCount: Int { return items.count }
}
