//
//  EmployeePasteboardWriter.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/25/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class EmployeePasteboardWriter: NSObject, NSPasteboardWriting {
    var employee: EmployeeViewModel
    var index: Int

    init(employee: EmployeeViewModel, at index: Int) {
        self.employee = employee
        self.index = index
    }

    func writableTypes(for _: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        return [.employee, .tableViewIndex]
    }

    func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
        switch type {
        case .employee:
            do {
                let jsonData = try JSONEncoder().encode(employee)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                return jsonString
            } catch {
                return nil
            }
        case .tableViewIndex:
            return index
        default:
            return nil
        }
    }
}

extension NSPasteboard.PasteboardType {
    static let employee = NSPasteboard.PasteboardType("com.heynow.employee")
    static let tableViewIndex = NSPasteboard.PasteboardType("com.heynow.tableViewIndex")
}

extension NSPasteboardItem {
    open func integer(forType type: NSPasteboard.PasteboardType) -> Int? {
        guard let data = data(forType: type) else { return nil }
        let plist = try? PropertyListSerialization.propertyList(
            from: data,
            options: .mutableContainers,
            format: nil
        )
        return plist as? Int
    }
}
