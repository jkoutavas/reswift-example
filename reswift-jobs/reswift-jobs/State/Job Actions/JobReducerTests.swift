//
//  JobReducerTests.swift
//  reswift-jobsTests
//
//  Created by Jay Koutavas on 3/28/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Foundation

import ReSwift
@testable import reswift_jobs
import XCTest

class JobReducerTests: XCTestCase {
    // MARK: Renaming action

    func testReduce_Rename_ReturnsListWithNewName() {
        let newName = "a new name"
        let oldJob = Job(title: nil, employees: [])
        let state = JobState(job: oldJob, selection: nil)

        let result = jobReducer(action: RenameJobAction(renameTo: newName), state: state)

        XCTAssertEqual(result.job.title, newName)
    }

    // MARK: Replacement action

    func testReduce_ReplaceAction_ReturnsStateWithNewList() {
        let newJob = Job(title: "new", employees: [])
        let oldJob = Job(title: "old", employees: [])
        let state = JobState(job: oldJob, selection: nil)

        let result = jobReducer(action: ReplaceJobAction(newJob: newJob), state: state)

        XCTAssert(result.job.hasEqualContent(newJob))
    }
}
