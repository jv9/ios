import Foundation
import SwiftyJSON

struct Building {
    let abbr: String?
    let address: String?
    let sqft: Int?
    let buildingNumber: Int?
    let name: String?

    init(buildingJSON: JSON) {
        abbr = buildingJSON["abbr"].string as String?
        address = buildingJSON["address"].string as String?
        sqft = buildingJSON["sqft"].intValue as Int?
        buildingNumber = buildingJSON["buildingNumber"].intValue as Int?
        name = buildingJSON["name"].string as String?
    }
}
