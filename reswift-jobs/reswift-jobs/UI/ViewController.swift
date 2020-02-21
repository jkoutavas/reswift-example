//
//  ViewController.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/4/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {

    @IBOutlet var tableView: NSOutlineView!
    @IBOutlet var jobTitleEdit: NSTextField!
    @IBOutlet var nameColumn: NSTableColumn!
    @IBOutlet var skillsColumn: NSTableColumn!

//    @IBOutlet var keyboardEventHandler: KeyboardEventHandler?

    var employees: [Employee] = []

    fileprivate var didLoad = false {
        didSet {
            delegate?.jobViewControllerDidLoad(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        keyboardEventHandler?.dataSource = self.dataSource
//        keyboardEventHandler?.store = self.store
        
        didLoad = true
    }

    override var representedObject: Any? {
        didSet {
            employees = representedObject as! [Employee]
            tableView?.reloadData()
        }
    }

   // MARK: - NSOutlineViewDataSource

   func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
       employees.count
   }

   func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
       employees[index]
   }

   // MARK: - NSOutlineViewDelegate

   func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
       return false
   }

   func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
       return true
   }

   func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
       guard let cell = outlineView.makeView(withIdentifier: tableColumn!.identifier, owner: self)
           as? NSTableCellView else { return nil }
       guard let textField = cell.textField else { return nil }

       if let employee = item as? Employee {
           switch tableColumn {
           case nameColumn:
               textField.stringValue = employee.name
           case skillsColumn:
               textField.stringValue = employee.skills
            default:
               print("Skipping \((tableColumn?.identifier)!.rawValue) column")
           }
       }

       return cell
   }
   
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
//           keyboardEventHandler?.store = store
       }
   }

   @IBAction func changeTitle(_ sender: AnyObject) {

       guard let textField = sender as? NSTextField else { return }

       let newName = textField.stringValue

       dispatchAction(RenameJobAction(renameTo: newName))
   }

   fileprivate func dispatchAction(_ action: Action) {

       store?.dispatch(action)
   }

   @objc func viewWillClose(_ notification: Notification) {
       delegate?.jobViewControllerWillClose(self)
   }
}

protocol JobViewControllerDelegate: class {

    func jobViewControllerDidLoad(_ controller: ViewController)
    func jobViewControllerWillClose(_ controller: ViewController)
}

protocol EmployeeTableDataSourceType {

    var tableDataSource: NSOutlineViewDataSource { get }

    var selectedRow: Int? { get }
    var selectedEmployee: EmployeeViewModel? { get }
    var employeeCount: Int { get }

    func updateContents(jobViewModel viewModel: JobViewModel)
    func employeeCellView(tableView: NSOutlineView, row: Int, owner: AnyObject) -> EmployeeCellView?
}

extension EmployeeTableDataSourceType where Self: NSOutlineViewDataSource {

    var tableDataSource: NSOutlineViewDataSource {
        return self
    }
}

// MARK: Displaying Data

protocol DisplaysJob {

    func displayJob(jobViewModel viewModel: JobViewModel)
}

extension ViewController: DisplaysJob {

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

/*
// MARK: Cell creation & event handling

extension ViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        guard let cellView = dataSource.jobCellView(tableView: tableView, row: row, owner: self)
            else { return nil }

        cellView.employeeItemChangeDelegate = self

        return cellView
    }

    func tableViewSelectionDidChange(_ notification: Notification) {

        let action: SelectionAction = {
            // "None" equals -1
            guard tableView.selectedRow >= 0 else { return .deselect }

            return .select(row: tableView.selectedRow)
        }()

        dispatchAction(action)
    }
}
*/

/*
extension ViewController: EmployeeItemChangeDelegate {

    func employeeItem(identifier: String, didChangeChecked checked: Bool) {

        guard let employeeID = EmployeeID(identifier: identifier)
            else { preconditionFailure("Invalid employee item identifier \(identifier).") }


        let action: EmployeeAction = {
         }()

        dispatchAction(action)

    }

    func employeeItem(identifier: String, didChangeName name: String) {

        guard let employeeID = EmployeeID(identifier: identifier)
            else { preconditionFailure("Invalid Employee item identifier \(identifier).") }

        dispatchAction(EmployeeAction.rename(employeeID, name: name))
    }
}
*/

/*
extension ViewController: EmployeeItemEditDelegate {

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
