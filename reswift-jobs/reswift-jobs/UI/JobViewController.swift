//
//  JobViewController.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/4/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class JobViewController: NSViewController {

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var jobTitleEdit: NSTextField!

//    @IBOutlet var keyboardEventHandler: KeyboardEventHandler?

    /// Changing the `delegate` while the window is displayed
    /// calls the `jobViewControllerDidLoad` callback
    /// on the new `delegate`.
    weak var delegate: JobViewControllerDelegate? {
        didSet {
            guard didLoad else { return }

            delegate?.jobViewControllerDidLoad(self)
        }
    }
   
    var dataSource: EmployeeTableDataSourceType = EmployeeTableDataSource() {
        didSet {
            tableView.dataSource = dataSource.tableDataSource
//           keyboardEventHandler?.dataSource = dataSource
       }
   }

    var store: JobStore? {

        didSet {
            dataSource.setStore(jobStore: store)
//           keyboardEventHandler?.store = store
       }
   }
       
    fileprivate var didLoad = false {
        didSet {
            delegate?.jobViewControllerDidLoad(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self.dataSource.tableDataSource
        tableView.delegate = self
        tableView.registerForDraggedTypes([.employee, .tableViewIndex])
        
//        keyboardEventHandler?.dataSource = self.dataSource
//        keyboardEventHandler?.store = self.store
        
        didLoad = true
    }

    @IBAction func changeTitle(_ sender: AnyObject) {

        guard let textField = sender as? NSTextField else { return }

        let newName = textField.stringValue

        store?.dispatch(RenameJobAction(renameTo: newName))
    }

    @objc func viewWillClose(_ notification: Notification) {
        delegate?.jobViewControllerWillClose(self)
    }
}

protocol JobViewControllerDelegate: class {

    func jobViewControllerDidLoad(_ controller: JobViewController)
    func jobViewControllerWillClose(_ controller: JobViewController)
}

protocol EmployeeTableDataSourceType {

    var tableDataSource: NSTableViewDataSource { get }

    var selectedRow: Int? { get }
    var selectedEmployee: EmployeeViewModel? { get }
    var employeeCount: Int { get }

    func updateContents(jobViewModel viewModel: JobViewModel)
    func getStore() -> JobStore?
    func setStore(jobStore: JobStore?)
    func employeeCellView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
}

extension EmployeeTableDataSourceType where Self: NSTableViewDataSource {

    var tableDataSource: NSTableViewDataSource {
        return self
    }
}

// MARK: Displaying Data

protocol DisplaysJob {

    func displayJob(jobViewModel viewModel: JobViewModel)
}

extension JobViewController: DisplaysJob {

    func displayJob(jobViewModel viewModel: JobViewModel) {

        displayJobTitle(viewModel: viewModel)
        updateTableDataSource(viewModel: viewModel)
        displaySelection(viewModel: viewModel)

        focusTableView()
    }

    fileprivate func displayJobTitle(viewModel: JobViewModel) {
        jobTitleEdit.stringValue = viewModel.title
    }

    fileprivate func updateTableDataSource(viewModel: JobViewModel) {
        dataSource.updateContents(jobViewModel: viewModel)
        tableView.reloadData()
    }

    fileprivate func displaySelection(viewModel: JobViewModel) {
        guard let selectedRow = viewModel.selectedRow else {
            tableView.selectRowIndexes(IndexSet(), byExtendingSelection: false)
            return
        }

        tableView.selectRowIndexes(IndexSet(integer: selectedRow), byExtendingSelection: false)
    }

    fileprivate func focusTableView() {
        self.view.window?.makeFirstResponder(tableView)
    }
}

// MARK: Cell creation & event handling

extension JobViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return dataSource.employeeCellView(tableView, viewFor: tableColumn, row: row)
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {

        let action: SelectionAction = {
            // "None" equals -1
            guard tableView.selectedRow >= 0 else { return .deselect }

            return .select(row: tableView.selectedRow)
        }()

        store?.dispatch(action)
    }
}

// TODO: support employee name and skills edits

/*
extension JobViewController: EmployeeItemChangeDelegate {

    func employeeItem(identifier: String, didChangeChecked checked: Bool) {

        guard let employeeID = EmployeeID(identifier: identifier)
            else { preconditionFailure("Invalid employee item identifier \(identifier).") }


        let action: EmployeeAction = {
         }()

        store?.dispatch(action)

    }

    func employeeItem(identifier: String, didChangeName name: String) {

        guard let employeeID = EmployeeID(identifier: identifier)
            else { preconditionFailure("Invalid Employee item identifier \(identifier).") }

        store?.dispatch(EmployeeAction.rename(employeeID, name: name))
    }
}

extension JobViewController: EmployeeItemEditDelegate {

    func editItem(row: Int, insertText text: String?) {

        guard let cellView = self.tableView.view(atColumn: 0, row: row, makeIfNecessary: true) as? EmployeeCellView,
            let textField = cellView.textField
            else { return }

        textField.selectText(self)

        guard let editor = textField.currentEditor(),
            let text = text
            else { return }

        editor.insertText(text)
    }
}
*/
