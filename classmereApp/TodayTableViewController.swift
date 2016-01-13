//
//  TodayViewController.swift
//  classmere
//
//  Created by Rutger Farry on 10/21/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit

class TodayTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let testView = UIStackView()

    let todayViewModel = TodayViewModel()
    var detailViewController: DetailViewController? = nil

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
        
        // TODO: REMOVE AFTER TESTING
        testView.frame = view.frame
        view.addSubview(testView)
        
        let image = UIImage(named: "building")
        let labelView = ClassmereCardLabel(
            icon: image,
            text: "Kearney 206",
            style: .Heading)
        let labelView2 = ClassmereCardLabel(
            icon: image,
            text: "Another Building 69",
            style: .Body)
        
        let cardView = ClassmereCardView(withMap: true, labels: [labelView, labelView2])
        cardView.backgroundColor = UIColor.whiteColor()
        testView.addArrangedSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = testView.layoutMarginsGuide
        cardView.topAnchor.constraintEqualToAnchor(margins.topAnchor)
        cardView.rightAnchor.constraintEqualToAnchor(margins.rightAnchor)
        cardView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor)
        cardView.leftAnchor.constraintEqualToAnchor(margins.leftAnchor)
        
        print(cardView.frame)
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

                controller.detailViewModel = DetailViewModel(course: course)
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
            return cell
    }

}
