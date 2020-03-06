//
//  JobState.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation
import ReSwift

struct JobState: StateType {
    var job: Job = Job.demoJob()
    var selection: SelectionState = nil
}
