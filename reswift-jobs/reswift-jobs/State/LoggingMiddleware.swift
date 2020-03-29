//
//  LoggingMiddleware.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/16/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import ReSwift

let loggingMiddleware: Middleware<JobState> = { _, _ in {
    next in {
        action in
            print("> \(action)")
            return next(action)
        }
    }
}
