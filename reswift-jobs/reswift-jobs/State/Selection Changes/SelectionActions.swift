//
//  SelectionActions.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/18/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

enum SelectionAction: Action {

    case deselect
    case select(row: Int)

    var selectionState: SelectionState {
        switch self {
        case .deselect: return nil
        case .select(row: let row): return row
        }
    }
}
