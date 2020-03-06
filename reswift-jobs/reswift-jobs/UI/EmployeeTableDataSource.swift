//
//  EmployeeTableDataSource.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/21/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class EmployeeTableDataSource: NSObject {
    var viewModel: JobViewModel?
    var store: JobStore?

    let emptyEmployee = EmployeeViewModel(identifier: "unknown", name: "unknown", skills: [])
}

extension EmployeeTableDataSource: NSTableViewDataSource {
    func numberOfRows(in _: NSTableView) -> Int {
        return viewModel?.itemCount ?? 0
    }

    func tableView(_: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        guard let viewModel = viewModel?.items[row]
        else { return nil }

        return EmployeePasteboardWriter(employee: viewModel, at: row)
    }

    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow _: Int,
                   proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        guard dropOperation == .above else { return [] }

        if let source = info.draggingSource as? NSTableView, source === tableView {
            tableView.draggingDestinationFeedbackStyle = .gap
        } else {
            tableView.draggingDestinationFeedbackStyle = .regular
        }
        return .move
    }

    func tableView(_: NSTableView, acceptDrop info: NSDraggingInfo, row: Int,
                   dropOperation _: NSTableView.DropOperation) -> Bool {
        guard let items = info.draggingPasteboard.pasteboardItems
        else { return false }

        let indexes = items.compactMap { $0.integer(forType: .tableViewIndex) }
        if !indexes.isEmpty {
            store?.dispatch(MoveEmployeeAction(from: indexes[0], to: row))
            return true
        }

        return true
    }
}

extension EmployeeTableDataSource: EmployeeTableDataSourceType {
    var selectedRow: Int? { return viewModel?.selectedRow }
    var selectedEmployee: EmployeeViewModel? { return viewModel?.selectedEmployee }
    var employeeCount: Int { return viewModel?.itemCount ?? 0 }

    func getStore() -> JobStore? {
        return store
    }

    func setStore(jobStore: JobStore?) {
        store = jobStore
    }

    func updateContents(jobViewModel viewModel: JobViewModel) {
        self.viewModel = viewModel
    }

    func employeeCellView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self)
            as? NSTableCellView else { return nil }
        guard let textField = cell.textField else { return nil }

        if let employee = viewModel?.items[row] {
            if tableColumn == tableView.tableColumns[0] {
                textField.stringValue = employee.name
            } else {
                textField.stringValue = employee.skills.joined(separator: ", ")
            }
        }

        return cell
    }
}
