# reswift-example #

*README last updated March 29th, 2020*

## Introduction

This repository contains my playground for learning the ins and outs of using [ReSwift](https://github.com/ReSwift/ReSwift). 

Right now there is one example application in this repository, `reswift-jobs`. There may be others down the road. We'll see.

### reswift-jobs 
`reswift-jobs` is a take-off of the [ReSwift example TODO app](https://github.com/ReSwift/ReSwift-Todo-Example) but instead of per-document TODO lists, it has per-document "Jobs" with lists of employees and their roles. 
![](reswift-jobs/screenshot.png)

This allows me to explore using a multicolumn NSTableView as well as moving employees between jobs and re-ordering them within a given job. In short, creating a number of new ReSwift actions on top of what the TODO example app does.

I chose this set of actions as a warm-up exercise for another app I'm working on, but chose employees and jobs as a nice break from the usual proverbial TODO list app. Besides, I wanted to literally type the code out from the TODO example app, not just copy the code whole cloth (though there definitely has been some of that done too.) This allows me to develop my "muscle memory" for working in ReSwift, which it, and the [Flux design pattern](https://code-cartoons.com/a-cartoon-guide-to-flux-6157355ab207) it is based on, is a new paradigm for me to wrap my wits about.

#### Featured example functions of the app are:

- Ablity to display, edit, undo/redo a job name
- Ablity to display employees assigned to a job
- Ablity to edit, undo/redo employee names and roles
- Ablity to re-order the list of employees with undo/redo
- Ablity to add an employee with undo/redo
- Ablity to delete an employee with undo/redo
- Ablity to copy an employee from one job to another with undo/redo

#### How unit tests are organized

A difference between the original ReSwift-Todo-Example and this repository is I like to place unit tests physically in the same directory as the source code under test. This makes them easier to find and manage in the IDE.

You can read about how I set this up in the project from the article [How to Rearrange Xcode Projects to Increase Testing](https://qualitycoding.org/rearrange-project-test-code/)


### Things I'm considering changing ###

I jotted down these notes when I studied the source code for `ReSwift-TODO-Example`:

* UndoActionContext:
// TODO: I'm not too keen about having specific data model objects being
// referenced from this seemingly generic "UndoActionContext" module.
// Perhaps it's just a matter of giving this module a data model specific name.

* UndoMiddleware is also too generically named. 

* RemoveIdempotentActionsMiddleware is also generically named, but should not exist at all. Author's comment: "I'd suggest you stop firing events when the view knows nothing has changed." -- LET US TRY REMOVING THIS MODULE IN MY EXAMPLE REPO.
