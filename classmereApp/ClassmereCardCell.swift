import UIKit

class ClassmereCardCell: UITableViewCell, ClassmereCardViewProtocol {
    
    private let cardView = ClassmereCardView()
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Cell customization
    override func prepareForReuse() {
        cardView.removeLabels()
    }
    
    // MARK: ClassmereCardViewProtocol
    
    func navigateToAddress(address: String) {
        cardView.navigateToAddress(address)
    }
    
    func addHeadingWithText(text: String) {
        cardView.addHeadingWithText(text)
    }
    
    func addLabelWithText(text: String, image: UIImage) {
        cardView.addLabelWithText(text, image: image)
    }
}