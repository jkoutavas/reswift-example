//
//  JobWindowController.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/9/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class JobWindowController: NSWindowController {

    var titlebarController: JobWindowTitleBarController?
    
    var store: JobStore? {

        didSet {
            titlebarController?.store = store
        }
    }
       
    override func windowDidLoad() {
        titlebarController = self.storyboard?.instantiateController(withIdentifier:
            NSStoryboard.SceneIdentifier("titlebarViewController"))
            as? JobWindowTitleBarController
        titlebarController?.layoutAttribute = .right

        // layoutAttribute has to be set before added to window
        self.window?.addTitlebarAccessoryViewController(titlebarController!)
    }
}
