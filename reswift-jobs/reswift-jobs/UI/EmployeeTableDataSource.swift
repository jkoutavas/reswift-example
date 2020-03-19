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
        if let source = info.draggingSource as? NSTableView, source === tableView {
            // We're moving an item within the same tableview
            tableView.draggingDestinationFeedbackStyle = .gap
            return .move
        } else {
            // We're copying an item from another table view
            tableView.draggingDestinationFeedbackStyle = .regular
            return .copy
        }
    }

    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int,
                   dropOperation _: NSTableView.DropOperation) -> Bool {
        guard let items = info.draggingPasteboard.pasteboardItems
        else { return false }

        if let source = info.draggingSource as? NSTableView, source === tableView {
            let indexes = items.compactMap { $0.integer(forType: .tableViewIndex) }
            if !indexes.isEmpty {
                store?.dispatch(MoveEmployeeAction(from: indexes[0], to: row))
                return true
            }
        } else {
            let employees = items.compactMap { $0.string(forType: .employee) }
            if !employees.isEmpty {
                do {
                    let jsonDecoder = JSONDecoder()
                    let viewModel = try jsonDecoder.decode(EmployeeViewModel.self,
                                                           from: employees[0].data(using: .utf8)!)
                    let employeeID = EmployeeID(identifier: viewModel.identifier)!
                    if store?.state.job.indexOf(employeeID: employeeID) != nil {
                        return false
                    }
                    store?.dispatch(InsertEmployeeAction(employee:
                        Employee(employeeID: employeeID, name: viewModel.name, skills: viewModel.skills),
                        index: row))
                    return true
                } catch {
                    return false
                }
            }
        }

        return false
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

    func renameEmployee(name: String, row: Int) {
        if let employee = viewModel?.items[row] {
            guard let employeeID = EmployeeID(identifier: employee.identifier)
            else { preconditionFailure("Invalid Employee item identifier \(employee.identifier).") }

            store?.dispatch(EmployeeAction.rename(employeeID, name: name))
        }
    }

    func editSkills(skillsString: String, row: Int) {
        if let employee = viewModel?.items[row] {
             guard let employeeID = EmployeeID(identifier: employee.identifier)
             else { preconditionFailure("Invalid Employee item identifier \(employee.identifier).") }

             store?.dispatch(EmployeeAction.editSkills(employeeID,
                skills: skillsString.components(separatedBy: ",")))
         }
    }
}
