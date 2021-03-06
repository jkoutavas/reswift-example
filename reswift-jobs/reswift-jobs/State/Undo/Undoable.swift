//
//  Undoable.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/12/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

protocol Undoable {
    /// Name used for e.g. "Undo" menu items.
    var name: String { get }

    var notUndoable: NotUndoable { get }
    var isUndoable: Bool { get }

    func inverse(context: UndoActionContext) -> UndoableAction?
}

extension Undoable where Self: UndoableAction {
    var notUndoable: NotUndoable {
        return NotUndoable(self)
    }
}
