//
//  PatchingResponder.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 3/3/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

protocol PatchingResponderType: class {
    var referenceResponder: NSResponder! { get }

    func patchIntoResponderChain()
}

extension PatchingResponderType where Self: NSResponder {
    func patchIntoResponderChain() {
        let oldResponder = referenceResponder.nextResponder
        referenceResponder.nextResponder = self
        nextResponder = oldResponder
    }
}

/// `NSResponder` that upon `awakeFromNib()` puts itself into the
/// responder chain right before `referenceResponder`.
class PatchingResponder: NSResponder, PatchingResponderType {
    @IBOutlet var referenceResponder: NSResponder!

    var initted = false

    override func awakeFromNib() {
        super.awakeFromNib()

        // awakeFromNib gets called twice from a storyboard
        // https://forums.developer.apple.com/thread/23853
        if initted { return }
        initted = true

        patchIntoResponderChain()
    }
}
