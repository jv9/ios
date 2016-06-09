//
//  TodayViewController.swift
//  classmere
//
//  Created by Rutger Farry on 10/21/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit

/**
 The view controller for the main view on app load.
 The static todayView is our initial design goal for what a possible personalized list of courses would look like.
 */
class TodayTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    // Define our demo/static today view
    let todayViewModel = TodayViewModel()
    var detailViewController: DetailViewController? = nil
    let cellColors = [
        UIColor(hue:0.02, saturation:0.64, brightness:0.95, alpha:1),
        UIColor(hue:0.51, saturation:0.81, brightness:0.91, alpha:1),
        UIColor(hue:0.45, saturation:0.89, brightness:0.84, alpha:1)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch courses
        todayViewModel.fetchCourseData([("PAC", 296), ("ECE", 271), ("Z", 477)]) {
            self.tableView.reloadData()

            let sections  = self.todayViewModel.courses.map({ course in
                return course.courseSections[0]
            })
            self.todayViewModel.fetchBuildingDataForSections(sections) {
                self.tableView.reloadData()
            }
        }

        // Split view controller
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let navigationController = controllers[controllers.count-1] as! UINavigationController
            self.detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Check if user is new to app
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if !firstLaunch {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            self.performSegueWithIdentifier("firstLaunch", sender: self)
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! DetailViewController
                let course = todayViewModel.courses[indexPath.section]
                
                // FIXME: A little bit sloppy here - since don't really need second parameter.
                controller.detailViewModel = DetailViewModel(course: course, courseSection: course.courseSections[0])
                print(course)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return todayViewModel.courses.count
    }

    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 122
    }

    func tableView(tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
            return 32
    }

    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 1
    }

    func tableView(tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clearColor()
            return headerView
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell",
                forIndexPath: indexPath) as? TodayTableViewCell else {
                    return TodayTableViewCell()
            }
            let course = todayViewModel.courses[indexPath.section]
            cell.populateWithCourse(course)
            cell.contentView.backgroundColor = cellColors[indexPath.section]
            return cell
    }
}
