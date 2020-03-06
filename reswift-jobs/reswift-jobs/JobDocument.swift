//
//  JobDocument.swift
//  reswift-jobs
//
//  Created by Jay Koutavas on 2/4/20.
//  Copyright © 2020 Heynow Software. All rights reserved.
//

import Cocoa

class JobDocument: NSDocument {

    // MARK: - Initialization

    lazy var store: JobStore = jobStore(undoManager: self.undoManager!)

    var presenter: JobPresenter!

    // MARK: - Saving/Loading Data

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let windowController =
            storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("JobWindowController")) as? JobWindowController
        else { return }
        self.addWindowController(windowController)
        windowController.store = self.store

        // Set the view controller's represented object as your document.
        if let contentVC = windowController.contentViewController as? JobViewController {
            self.presenter = JobPresenter(view: contentVC)
            contentVC.store = self.store
            contentVC.delegate = self
        }
    }

    override func data(ofType typeName: String) throws -> Data {
        var data: Data
        do {
            data = try JSONEncoder().encode(store.state.job)
        } catch {
            data = Data()
            throw NSError(domain: NSOSStatusErrorDomain, code: writErr, userInfo: nil)
        }
        return data
    }

    override func read(from data: Data, ofType typeName: String) throws {
        do {
            let job = try JSONDecoder().decode(Job.self, from: data)
            store.dispatch(ReplaceJobAction(newJob: job))
        } catch {
            throw NSError(domain: NSOSStatusErrorDomain, code: readErr, userInfo: nil)
        }
    }
}

extension JobDocument: JobViewControllerDelegate {
    func jobViewControllerDidLoad(_ controller: JobViewController) {

        store.subscribe(presenter)
    }

    func jobViewControllerWillClose(_ controller: JobViewController) {

        store.unsubscribe(presenter)
    }
}
