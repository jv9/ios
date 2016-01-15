import UIKit

class DetailViewController: UITableViewController {

    var detailViewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            switch indexPath.section {
            case 0:
                return 122
            case 1:
                return 192
            default:
                // This shouldn't happen
                return 0
            }
    }

    override func tableView(tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
            return 32
    }

    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 1
    }

    override func tableView(tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clearColor()
            return headerView
    }

    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell",
                    forIndexPath: indexPath) as? TodayTableViewCell else {
                        return TodayTableViewCell()
                }
                let course = detailViewModel.course
                cell.populateWithCourse(course)
                let backgroundColor = UIColor(hue:0.02, saturation:0.64, brightness:0.95, alpha:1)
                cell.contentView.backgroundColor = backgroundColor
                return cell

            case 1:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("MapCell",
                    forIndexPath: indexPath) as? MapTableViewCell else {
                        return MapTableViewCell()
                }
                if let building = detailViewModel.course.courseSections[0].building,
                    address = building.address {
                        cell.navigateToAddress(address)
                }
                return cell

            default:
                fatalError("Tableview shouldn't contain more than 2 cells")
            }
        }
}
