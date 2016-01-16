import UIKit

final class ClassmereCardView: UIView {
    
    private var mapView: ClassmereMapView?
    private let cardStackView = UIStackView()
    
    var mapAddress: String?
    var labels: [ClassmereCardLabel]?
    
    convenience init(withMap: Bool, labels: [ClassmereCardLabel]) {
        self.init(frame: CGRect())
        
        self.labels = labels
        for label in labels {
            cardStackView.addArrangedSubview(label)
        }
        
        if withMap {
            mapView = ClassmereMapView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        mapView = nil
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        mapView = nil
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        if let mapView = mapView {
            addSubview(mapView)
            mapView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
            mapView.heightAnchor.constraintEqualToConstant(280.0).active = true
            mapView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
            mapView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        }
        
        addSubview(cardStackView)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.axis = .Vertical
        cardStackView.alignment = .Fill
        cardStackView.distribution = .Fill
        cardStackView.spacing = 8.0
        cardStackView.baselineRelativeArrangement = true
        
        let cardStackViewTopAnchor = mapView?.bottomAnchor ?? topAnchor
        cardStackView.topAnchor.constraintEqualToAnchor(cardStackViewTopAnchor).active = true
        cardStackView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        cardStackView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
    }
    
    func addClassmereLabel(label: ClassmereCardLabel) {
        
    }
}