//
//  ViewController.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/4/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {

    @IBOutlet var employeeTable: NSOutlineView?
    @IBOutlet var nameColumn: NSTableColumn!
    @IBOutlet var skillsColumn: NSTableColumn!
    
    var employees: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
            employees = representedObject as! [Employee]
            employeeTable?.reloadData()
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

   func outlineView(_ outlineVIew: NSOutlineView, shouldSelectItem item: Any) -> Bool {
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
}

