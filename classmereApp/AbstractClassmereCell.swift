import UIKit

class AbstractClassmereCell: UITableViewCell {
    override func awakeFromNib() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }
}
