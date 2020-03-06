//
//  ArrayUtil.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 3/1/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

extension Array {
    // These functions from sooop on GitHub
    // https://gist.github.com/sooop/3c964900d429516ba48bd75050d0de0a
    mutating func move(from start: Index, to end: Index) {
        guard (0 ..< count) ~= start, (0 ... count) ~= end else { return }
        if start == end { return }
        let targetIndex = start < end ? end - 1 : end
        insert(remove(at: start), at: targetIndex)
    }

    mutating func move(from indexes: IndexSet, to toIndex: Index) {
        let movingData = indexes.map { self[$0] }
        let targetIndex = toIndex - indexes.filter { $0 < toIndex }.count
        for (index, elem) in indexes.enumerated() {
            remove(at: elem - index)
        }
        insert(contentsOf: movingData, at: targetIndex)
    }
}
