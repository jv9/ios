import UIKit
import Mapbox

final class ClassmereMapView: UIView {
    private let internalMapView = MGLMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        internalMapView.frame = bounds
        internalMapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        let locationCoordinate = CLLocationCoordinate2D(
            latitude: 44.56,
            longitude: -123.27)
        internalMapView.setCenterCoordinate(
            locationCoordinate,
            zoomLevel: 12.0,
            animated: false)
        
        addSubview(internalMapView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension ClassmereMapView {
    func centerMapOnAddress() {
        return
    }
}
