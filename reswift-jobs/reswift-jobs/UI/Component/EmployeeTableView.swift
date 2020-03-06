//
//  EmployeeTableView.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 3/3/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class EmployeeTableView: NSTableView {
    override func keyDown(with theEvent: NSEvent) {
        // Consume keyDown to prevent interpretation here
        nextResponder?.interpretKeyEvents([theEvent])
    }
}
